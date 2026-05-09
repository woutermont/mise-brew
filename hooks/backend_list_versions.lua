--- Lists available versions for a tool in this backend
--- Documentation: https://mise.jdx.dev/backend-plugin-development.html#backendlistversions
--- @param ctx {tool: string} Context (tool = the tool name requested)
--- @return {versions: string[]} Table containing list of available versions
function PLUGIN:BackendListVersions(ctx)
    local cmd = require("cmd")
    local json = require("json")

    local tool = ctx.tool

    if not tool or tool == "" then
        error("Tool name cannot be empty")
    end

    local result = cmd.exec("brew info --json=v2 " .. tool .. " | jq '[.formulae.[].versions.stable, .casks.[].version]'")

    if not result or result == "" then
        return { versions = {} }
    end

    return { versions = json.decode(result) or {} }
end
