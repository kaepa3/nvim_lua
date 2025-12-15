local snippet_dir = vim.fn.stdpath("config") .. "/snippets"
vim.g.vsnip_snippet_dir = snippet_dir

local fn = vim.fn

fn["ddc#custom#patch_global"]("ui", "pum")
fn["ddc#custom#patch_global"]("sources", { "lsp", "around", "vsnip" })
fn["ddc#custom#patch_global"]({
    autoCompleteDelay = 50,
    sourceOptions = {
        _ = {
            minAutoCompleteLength = 2,
            matchers = { "matcher_fuzzy" },
            sorters = { "sorter_fuzzy" },
            converters = { "converter_fuzzy" },
        },
        lsp = {
            mark = "[lsp]",
            forceCompletionPattern = [[\.\w*|:\w*|->\w*]],
            minAutoCompleteLength = 0,
            matchers = { "matcher_head" },
            sorters = { "sorter_rank" },
            converters = { "converter_fuzzy" },
            maxItems = 40,
        },
        around = {
            mark = "[a]",
        },
        vsnip = {
            mark = "[s]",
        },
    },
    sourceParams = {
        lsp = {
            enableResolveItem = false,
            enableAdditionalTextEdit = true,
            timeout = 1000,
        },
    },
    autoCompleteEvents = { "InsertEnter", "TextChangedI", "TextChangedP" },
})

vim.fn["ddc#enable"]()
