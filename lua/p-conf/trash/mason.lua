local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
require("mason").setup()
require("mason-lspconfig").setup()
local nvim_lsp = require("lspconfig")

local function create_opt(server_name)
    local opts = {}

    local node_root_dir = nvim_lsp.util.root_pattern("package.json")
    local is_node_repo = node_root_dir(vim.api.nvim_buf_get_name(0)) ~= nil

    if server_name == "tsserver" then
        if is_node_repo then
            opts.root_dir = node_root_dir
        else
            return nil
        end
    elseif server_name == "eslint" then
        if is_node_repo then
            opts.root_dir = node_root_dir
        else
            return nil
        end
    elseif server_name == "lua_ls" then
        opts.settings = {
            Lua = {
                diagnostics = {
                    globals = { "vim" },
                },
            },
        }
    elseif server_name == "denols" then
        if not is_node_repo then
            opts.root_dir = nvim_lsp.util.root_pattern("deno.json", "deno.jsonc", "deps.ts", "import_map.json")
            opts.init_options = {
                lint = true,
                unstable = true,
                suggest = {
                    imports = {
                        hosts = {
                            ["https://deno.land"] = true,
                            ["https://cdn.nest.land"] = true,
                            ["https://crux.land"] = true,
                        },
                    },
                },
            }
        else
            return nil
        end
    end

    opts.capabilities = capabilities
    opts.on_attach = on_attach
    return opts
end

require("mason-lspconfig").setup_handlers({
    function(server_name)
        local opts = create_opt(server_name)
        if opts ~= nil then
            require("lspconfig")[server_name].setup(opts)
        end
    end,
})
