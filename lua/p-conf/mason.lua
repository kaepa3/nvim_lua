require("mason").setup({
    ensure_installed = {
        "arduino_language_server",
        "clangd",
        "eslint",
        "lua_ls",
        "deno",
        "gopls",
        "typescript-language-server",
    },
})
require("mason-lspconfig").setup()

local nvim_lsp = require("lspconfig")
local capabilities = require("blink.cmp").get_lsp_capabilities()

local function create_opt(server_name)
    local node_root_dir = nvim_lsp.util.root_pattern("package.json")
    local is_node_repo = node_root_dir(vim.api.nvim_buf_get_name(0)) ~= nil
    local opts = { capabilities = capabilities }

    if server_name == "arduino_language_server" then
        opts.cmd = {
            "-cli",
            "/opt/homebrew/bin/arduino-cli",
            "-cli-config",
            "~/Library/Arduino15/arduino-cli.yaml",
        }
        opts.autostart = true
        opts.enable = true
        opts.filetypes = { "arduino", "ino" }
    elseif server_name == "eslint" then
        if is_node_repo then
            opts.root_dir = node_root_dir
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
        end
    elseif server_name == "gopls" then
        opts.settings = {
            gopls = {
                completeUnimported = true,
                usePlaceholders = true,
            },
        }
    elseif server_name == "ts_ls" then
        local path = vim.fn.expand("$MASON/packages/vue-language-server/node_modules/@vue/language-server")
        opts.init_options = {
            plugins = {
                {
                    name = "@vue/typescript-plugin",
                    location = path,
                    languages = { "vue" },
                },
            },
        }
        opts.filetypes = {
            "typescript",
            "javascript",
            "javascriptreact",
            "typescriptreact",
            "vue", -- ★ 必須
        }
        opts.timeout = 10000 -- 起動が遅いことがあるため延長
    elseif server_name == "vue_ls" then -- (vue_ls ではなく volar)
        opts.timeout = 10000 -- 起動が遅いことがあるため延長
    end
    return opts
end

-- 5. 「強制呼び出し」: lspconfig の設定名をリスト化
local servers_to_configure = {
    "arduino_language_server",
    "clangd",
    "eslint",
    "lua_ls",
    "denols",
    "gopls",
    "ts_ls",
    "vue_ls",
}

-- 6. 「強制呼び出し」: 手動でループして vim.lsp.config を呼ぶ
for _, server_name in ipairs(servers_to_configure) do
    local opts = create_opt(server_name)

    if opts ~= nil then
        vim.lsp.config(server_name, opts)
    else
        vim.notify(server_name .. " の設定は nil のためスキップ", vim.log.levels.WARN)
    end
end
