local null_ls = require("null-ls")
local h = require("null-ls.helpers")
null_ls.setup({
    sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.black.with({ filetypes = { "python" } }),
        null_ls.builtins.formatting.prettier,
        null_ls.builtins.formatting.fixjson,
        null_ls.builtins.diagnostics.textlint.with({ filetypes = { "markdown" } }),
    },
})
