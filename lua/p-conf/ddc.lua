local snippet_dir = "~/.config/nvim/snippets"
vim.g.vsnip_snippet_dir = snippet_dir

vim.fn["ddc#custom#patch_global"]('ui', 'pum')
vim.fn["ddc#custom#patch_global"]('sources', { 'around', "vim-lsp", "lsp", "vsnip" })
vim.fn["ddc#custom#patch_global"]('sourceOptions', {
    ["vsnip"] = {
        mark = '[s]',
    },
    ["around"] = {
        mark = '[a]',
        forceCompletionPattern = { [['\.\w*|:\w*|->\w*']] },
    },
    ["lsp"] = {
        mark = '[l]',
        forceCompletionPattern = { [['\.\w*|:\w*|->\w*']] },
        minAutoCompleteLength = 2,
    },
    ["vim-lsp"] = {
        mark = '[vl]',
        --forceCompletionPattern = { [['\.\w*|:\w*|->\w*']] },
        forceCompletionPattern = { [[ '\.|:|->' ]] },
        minAutoCompleteLength = 1,
    },
    _ = {
        matchers = { 'matcher_fuzzy' },
        sorters = { 'sorter_fuzzy' },
        converters = { 'converter_fuzzy' },
    }
})


local capabilities = require("ddc_source_lsp").make_client_capabilities()
require("lspconfig").denols.setup({
    capabilities = capabilities,
})
vim.fn["ddc#enable"]()
