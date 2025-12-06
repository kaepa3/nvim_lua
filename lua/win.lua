vim.o.shell = "pwsh.exe"
vim.o.shellcmdflag = "/c"
vim.api.nvim_create_user_command("TermMSYS", function()
    vim.cmd("terminal C:/msys64/msys2_shell.cmd -defterm -here -no-start -faststart")
end, {})
