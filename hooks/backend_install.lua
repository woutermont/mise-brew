--- Installs a specific version of a tool
--- Documentation: https://mise.jdx.dev/backend-plugin-development.html#backendinstall
--- @param ctx {tool: string, version: string, install_path: string} Context
--- @return table Empty table on success
function PLUGIN:BackendInstall(ctx)
    local cmd = require("cmd")
    local json = require("json")

    local tool = ctx.tool
    local version = ctx.version -- ignored
    local install_path = ctx.install_path -- ignored
    local brew_check = cmd.exec("command -v brew")

    if not brew_check or brew_check == "" then
        error("'brew' not found in $PATH")
    end

    if not tool or tool == "" then
        error("Tool name cannot be empty")
    end

    local result = cmd.exec("brew info --json=v2 " .. tool .. " | jq '[.formulae.[].versions.stable, .casks.[].version]'")

    if not result or result == "" then
        error("No formula or cask found for " .. tool)
    end

    local versions = json.decode(result) or {}

    for i, v in pairs(versions) do
        if v == version then break end

        if i == #versions then
            error("Homebrew only supports installing the following versions of " .. tool .. ": " .. table.concat(versions, ", "))
        end
    end

    if install_path and not install_path == "" then
        warn("Homebrew backend installs to default prefix " .. cmd.exec("brew --prefix"))
    end

    if pcall(function () cmd.exec("brew list " .. tool) end) then return {} end

    if not pcall(function () cmd.exec("brew install " .. tool) end) then
        error("Homebrew failed to install " .. tool)
    end

    return {}
end
