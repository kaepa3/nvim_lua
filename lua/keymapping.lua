vim.g.mapleader = " "

local lspinstaller = require("nvim-lsp-installer")

lspinstaller.setup({})
--vim
vim.keymap.set("n", "gn", ":bn<CR>")
vim.keymap.set("n", "gp", ":bp<CR>")
vim.keymap.set("n", "<ESC><ESC>", ":nohl<CR>")
vim.keymap.set("i", "jj", "<Esc>")

--general
vim.keymap.set("i", "<C-o>", "<ESC>o")

--lsp
vim.keymap.set("n", "<C-j>", "<cmd>lua vim.lsp.buf.definition()<CR>")
vim.keymap.set("n", "<leader>j", "<cmd>lua vim.lsp.buf.hover()<CR>")
vim.keymap.set("n", "<C-k>", "<cmd>lua vim.lsp.buf.format({async=true})<CR>")
vim.keymap.set("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>")

--telescope
vim.keymap.set("n", "<leader>t", "<cmd>Telescope<CR>")
vim.keymap.set("n", "<leader>f", "<cmd>Telescope find_files<CR>")

--terminal
vim.keymap.set("t", "<C-q>", "<C-\\><C-n><CR>")

-- luasnip
vim.api.nvim_set_keymap(
    "i",
    "<C-j>",
    'luasnip#expand_or_jumpable() ? "<Plug>luasnip-expand-or-jump" : ""',
    { expr = true, silent = true }
)
vim.api.nvim_set_keymap(
    "s",
    "<C-j>",
    'luasnip#expand_or_jumpable() ? "<Plug>luasnip-expand-or-jump"',
    { expr = true, silent = true }
)
-- vim.api.nvim_set_keymap("s", "<C-j>", "v:lua.expand()", { expr = true, silent = true })
vim.api.nvim_set_keymap(
    "i",
    "<C-k>",
    'luasnip#jumpable(-1) ? "<Plug>luasnip-jump-prev" : ""',
    { expr = true, silent = true }
)
vim.api.nvim_set_keymap(
    "s",
    "<C-k>",
    -- ":lua.backward()"
    'luasnip#jumpable(-1) ? "<Plug>luasnip-jump-prev" : ""',
    { expr = true, silent = true }
)

function go_org_imports(wait_ms)
    local params = vim.lsp.util.make_range_params()
    params.context = { only = { "source.organizeImports" } }
    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, wait_ms)
    for _, res in pairs(result or {}) do
        for _, r in pairs(res.result or {}) do
            if r.edit then
                vim.lsp.util.apply_workspace_edit(r.edit, "UTF-8")
            else
                vim.lsp.buf.execute_command(r.command)
            end
        end
    end
end

vim.cmd([[ autocmd BufWritePre *.go lua go_org_imports(1000) ]])
