local function show_macro_recording()
    local recording_register = vim.fn.reg_recording()
    if recording_register == "" then
        return ""
    else
        return "Recording @" .. recording_register
    end
end

local lsp_names = function()
    local clients = {}
    for _, client in ipairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
        if client.name == "null-ls" then
            local sources = {}
            for _, source in ipairs(require("null-ls.sources").get_available(vim.bo.filetype)) do
                table.insert(sources, source.name)
            end
            table.insert(clients, "null-ls(" .. table.concat(sources, ", ") .. ")")
        else
            table.insert(clients, "1:" .. client.name)
        end
    end
    return " " .. table.concat(clients, ", ")
end
require("lualine").setup({
    options = {
        icons_enabled = true,
    },
    sections = {
        lualine_b = {
            {
                "macro-recording",
                fmt = show_macro_recording,
            },
        },
        lualine_x = { 'fileformat', 'encoding', 'filetype', lsp_names },
    },
})
