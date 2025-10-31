require("mason").setup({
    ensure_installed = {
        'arduino_language_server',
        'clangd',
        'eslint',
        'lua_ls',
        'deno',
        'gopls',
        'arduino_language_server',
        'typescript-language-server',
    },
})
require("mason-lspconfig").setup()

local nvim_lsp = require("lspconfig")
local capabilities = require('ddc_source_lsp').make_client_capabilities()

local on_attach = function(client, bufnr)
    local capabilities = client.server_capabilities
    if capabilities.codeActionProvider and capabilities.codeActionProvider.codeActionKinds then
        local organizes_imports = false
        for _, kind in ipairs(capabilities.codeActionProvider.codeActionKinds) do
            if kind == "source.organizeImports" then
                organizes_imports = true
                break
            end
        end

        if organizes_imports then
            -- 保存前に "source.organizeImports" を実行するautocmd
            local augroup = vim.api.nvim_create_augroup("LspOrganizeImportsOnSave", { clear = true })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()
                    -- ここで "format" ではなく "code_action" を呼ぶ
                    -- これで goimports と同じ動作になる
                    vim.lsp.buf.code_action({
                        context = { diagnostics = {} },
                        filter = function(a) return a.kind == 'source.organizeImports' end,
                        apply = true,
                        -- 同期的に実行するためのタイムアウト（重要）
                        timeout_ms = 1000,
                    })
                end,
            })
        end
    end
end



local function create_opt(server_name)
    local opts = { capabilities = capabilities }

    local node_root_dir = nvim_lsp.util.root_pattern("package.json")
    local is_node_repo = node_root_dir(vim.api.nvim_buf_get_name(0)) ~= nil

    if server_name == "arduino_language_server" then
        opts.cmd = {
            "-cli", "/opt/homebrew/bin/arduino-cli",
            "-cli-config", "~/Library/Arduino15/arduino-cli.yaml",
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
        else
            return nil
        end
    elseif server_name == "gopls" then
        opts.settings = {
            gopls = {
                completeUnimported = true,
                usePlaceholders = true,
            },
        }
    elseif server_name == "ts_ls" then
        local path = vim.fn.expand "$MASON/packages/vue-language-server/node_modules/@vue/language-server"
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
            "typescript", "javascript", "javascriptreact", "typescriptreact",
            "vue",                      -- ★ 必須
        }
        opts.timeout = 10000            -- 起動が遅いことがあるため延長
    elseif server_name == "vue_ls" then -- (vue_ls ではなく volar)
        opts.timeout = 10000            -- 起動が遅いことがあるため延長
    end
    opts.on_attach = on_attach
    return opts
end


-- 5. 「強制呼び出し」: lspconfig の設定名をリスト化
local servers_to_configure = {
    'arduino_language_server',
    'clangd',
    'eslint',
    'lua_ls',
    'denols',
    'gopls',
    'ts_ls',
    'vue_ls',
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
