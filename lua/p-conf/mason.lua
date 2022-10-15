local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
require("mason").setup()
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers({
    function(server_name) -- default handler (optional)
        if server_name == "sumneko_lua" then
            require("lspconfig")[server_name].setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
        else
            require("lspconfig")[server_name].setup({
                capabilities = capabilities,
                on_attach = on_attach,
            })
        end
    end,
})
