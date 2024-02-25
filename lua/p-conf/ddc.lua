local snippet_dir = "~/.config/nvim/snippets"
vim.g.vsnip_snippet_dir = snippet_dir

vim.fn["ddc#custom#patch_global"]('ui', 'native')
vim.fn["ddc#custom#patch_global"]('sources', { 'around', "vim-lsp", "lsp", "vsnip" })
vim.fn["ddc#custom#patch_global"]('sourceOptions', {
    ["vsnip"] = {
        mark = '[s]',
        --        forceCompletionPattern = {[['\.\w*|:\w*|->\w*']]},
    },
    ["around"] = {
        mark = '[a]',
        forceCompletionPattern = { [['\.\w*|:\w*|->\w*']] },
    },
    ["lsp"] = {
        mark = '[l]',
        forceCompletionPattern = { [['\.\w*|:\w*|->\w*']] },
    },
    ["vim-lsp"] = {
        mark = '[vl]',
        forceCompletionPattern = { [['\.\w*|:\w*|->\w*']] },
    },
    _ = {
        matchers = { 'matcher_fuzzy' },
        sorters = { 'sorter_fuzzy' },
        converters = { 'converter_fuzzy' },
    }
})

vim.fn["ddc#custom#patch_global"]('sourceParams', {
    ["vim-lsp"] = {
        snippetEngine = vim.fn["denops#callback#register"](function(body) vim.fn["vsnip#anonymous"](body) end),
        enableResolveItem = true,
        enableAdditionalTextEdit = true,
    },
})

local capabilities = require("ddc_source_lsp").make_client_capabilities()
require("lspconfig").denols.setup({
    capabilities = capabilities,
})
vim.fn["ddc#enable"]()
