-- Term and vertical
vim.api.nvim_create_user_command("VTerm", function(opts)
    vim.cmd("vsplit")
    vim.cmd("wincmd l")
    vim.cmd("terminal")
end, {})
