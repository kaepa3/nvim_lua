local snippet_dir = "~/.config/nvim/snippets"
vim.g.vsnip_snippet_dir = snippet_dir

local fn = vim.fn

fn["ddc#custom#patch_global"]('ui', 'pum')
fn["ddc#custom#patch_global"]('sources', { "lsp", 'around', "vsnip" })
fn["ddc#custom#patch_global"] {
    sourceOptions = {
        _ = {
            minAutoCompleteLength = 2,
            matchers = { 'matcher_fuzzy' },
            sorters = { 'sorter_fuzzy' },
            converters = { 'converter_fuzzy' },
        },
        lsp = {
            mark = '[lsp]',
            forceCompletionPattern = [[\.\w*|:\w*|->\w*]],
            minAutoCompleteLength = 1,
            matchers = { 'matcher_fuzzy' },
            sorters = { 'sorter_fuzzy' },
            converters = { 'converter_fuzzy' },
        },
        around = {
            mark = '[a]',
        },
        vsnip = {
            mark = '[s]',
        },
    },
    sourceParams = {
        lsp = {
            enableResolveItem = true,
            enableAdditionalTextEdit = true,
        },
    },
    autoCompleteEvents = { 'InsertEnter', 'TextChangedI', 'TextChangedP' },
}

vim.fn["ddc#enable"]()
