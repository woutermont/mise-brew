--- Sets up environment variables for a tool
--- Documentation: https://mise.jdx.dev/backend-plugin-development.html#backendexecenv
--- @param ctx {install_path: string, tool: string, version: string} Context
--- @return {env_vars: table[]} Table containing list of environment variable definitions
function PLUGIN:BackendExecEnv(ctx)
    local cmd = require("cmd")
    local file = require("file")

    local tool = ctx.tool
    local version = ctx.version -- ignored
    local install_path = ctx.install_path -- ignored
    local prefix = cmd.exec("brew --prefix 2>/dev/null")

    if not prefix or prefix == "" then
        error("Could not determine Homebrew prefix")
    end

    if not tool or tool == "" then
        error("Tool name cannot be empty")
    end

    return {
        env_vars = {
            {
                key = "PATH",
                value = file.join_path(prefix, "bin"),
            },
        }
    }
end
