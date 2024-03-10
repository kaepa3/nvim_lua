vim.g.mapleader = " "

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
vim.keymap.set('n', '<leader>s', '<cmd>lua vim.lsp.buf.references()<CR>')

--vsnip
local keymap = vim.api.nvim_set_keymap
local options = { silent = true, expr = true }

keymap('i', '<C-j>', "pumvisible() ? '<C-n>' : vsnip#jumpable(1)     ? '<Plug>(vsnip-jump-next)' : '<Tab>'", options)
keymap('i', '<S-Tab>', "pumvisible() ? '<C-n>' : vsnip#jumpable(-1)    ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>'", options)
keymap('s', '<C-j>', "vsnip#jumpable(1)  ? '<Plug>(vsnip-jump-next)' : '<Tab>'", options)
keymap('s', '<S-Tab>', "vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)' : '<Tab>'", options)

--pum
vim.keymap.set("i", "<C-n>", "<cmd>call pum#map#insert_relative(+1)<CR>")
vim.keymap.set("i", "<C-p>", "<cmd>call pum#map#insert_relative(-1)<CR>")
vim.keymap.set("i", "<C-y>", "<cmd>call pum#map#confirm()<CR>")
vim.keymap.set("i", "<C-e>", "<cmd>call pum#map#cancel()<CR>")

--telescope
vim.keymap.set("n", "<leader>t", "<cmd>Telescope<CR>")
vim.keymap.set("n", "<leader>f", "<cmd>Telescope find_files<CR>")

--terminal
vim.keymap.set("t", "<C-q>", "<C-\\><C-n><CR>")

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

-- Term and vertical
vim.api.nvim_create_user_command("VTerm", function(opts)
    vim.cmd("vsplit")
    vim.cmd("wincmd l")
    vim.cmd("terminal")
end, {})
