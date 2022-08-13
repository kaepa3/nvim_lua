vim.g.mapleader = ' '

local lspinstaller = require 'nvim-lsp-installer'

lspinstaller.setup {}

--general
vim.keymap.set("i", "<silent><C-n>", "<ESC>o")

--lsp
vim.keymap.set("n", "<C-j>", "<cmd>lua vim.lsp.buf.definition()<CR>")
vim.keymap.set('n', '<C-k>', '<cmd>lua vim.lsp.buf.formatting()<CR>')

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
