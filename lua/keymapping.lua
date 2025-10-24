vim.g.mapleader = " "

--vim
vim.keymap.set("n", "gn", ":bn<CR>")
vim.keymap.set("n", "gp", ":bp<CR>")
vim.keymap.set("n", "<ESC><ESC>", ":nohl<CR>")
vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("n", "<leader>n", ":tabnew<CR>")
vim.keymap.set("n", "<C-n>", ":tabNext<CR>")


--general
vim.keymap.set("i", "<C-o>", "<ESC>o")

--lsp
vim.keymap.set("n", "<C-j>", "<cmd>lua vim.lsp.buf.definition()<CR>")
vim.keymap.set("n", "<leader>j", "<cmd>lua vim.lsp.buf.hover()<CR>")
vim.keymap.set("n", "<C-k>", "<cmd>lua vim.lsp.buf.format({async=true})<CR>")
vim.keymap.set("n", "<leader>r", "<cmd>lua vim.lsp.buf.rename()<CR>")
vim.keymap.set('n', '<leader>s', '<cmd>lua vim.lsp.buf.references()<CR>')

--vsnip
local keymap = vim.api.nvim_set_keymap
local options = { silent = true, expr = true }

keymap('i', '<C-j>', "pumvisible() ? '<C-n>' : vsnip#jumpable(1)     ? '<Plug>(vsnip-jump-next)' : '<Tab>'", options)
keymap('i', '<S-Tab>', "pumvisible() ? '<C-n>' : vsnip#jumpable(-1)    ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'", options)
keymap('s', '<C-j>', "vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<Tab>'", options)
keymap('s', '<S-Tab>', "vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)' : '<Tab>'", options)

--pum
local pum_visible = vim.fn["pum#visible"]
vim.keymap.set("i", "<C-n>", "<cmd>call pum#map#insert_relative(+1)<CR>")
vim.keymap.set("i", "<C-p>", "<cmd>call pum#map#insert_relative(-1)<CR>")
vim.keymap.set("i", "<C-y>", "<cmd>call pum#map#confirm()<CR>")
vim.keymap.set("i", "<C-e>", "<cmd>call pum#map#cancel()<CR>")
vim.keymap.set("i", "<CR>", function()
    return pum_visible() and "<Cmd>call pum#map#confirm()<CR>" or "<CR>"
end, { expr = true, silent = true })

--telescope
vim.keymap.set("n", "<leader>t", "<cmd>Telescope<CR>")
vim.keymap.set("n", "<leader>f", "<cmd>Telescope find_files<CR>")

--terminal
vim.keymap.set("t", "<C-q>", "<C-\\><C-n><CR>")

-- Term and vertical
vim.api.nvim_create_user_command("VTerm", function(opts)
    vim.cmd("vsplit")
    vim.cmd("wincmd l")
    vim.cmd("terminal")
end, {})
