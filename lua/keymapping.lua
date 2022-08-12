vim.g.mapleader = ' '

local lspinstaller = require'nvim-lsp-installer'
local lspconfig = require'lspconfig'

lspinstaller.setup{}

vim.keymap.set( "n", "<C-j>", "<cmd>lua vim.lsp.buf.definition()<CR>")
vim.keymap.set( "n", "<leader>t", "<cmd>Telescope<CR>")
vim.keymap.set( "n", "<leader>f", "<cmd>Telescope find_files<CR>")
     

