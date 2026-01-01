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
vim.keymap.set("n", "<leader>s", "<cmd>lua vim.lsp.buf.references()<CR>")

--telescope
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>t", "<cmd>Telescope<CR>")
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fw", builtin.grep_string, {})

-- oil
vim.keymap.set("n", "<leader>o", "<cmd>Oil<CR>", {})

--terminal
vim.keymap.set("t", "<C-q>", "<C-\\><C-n><CR>")

-- Term and vertical
vim.api.nvim_create_user_command("VTerm", function(opts)
    vim.cmd("vsplit")
    vim.cmd("wincmd l")
    vim.cmd("terminal")
end, {})
