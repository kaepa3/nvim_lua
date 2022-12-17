require("styler").setup({
    themes = {
        help = { colorscheme = "tokyonight" },
    },
})
--colorchg
BASE_COLORSCHEME = "nightfox"
ACTIVE_COLORSCHEME = "nightfox"
INACTIVE_COLORSCHEME = "nordfox"

-- Apply colorscheme
vim.cmd("colorscheme " .. BASE_COLORSCHEME)
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
    group = vim.api.nvim_create_augroup("theme-custom", {}),
    callback = function(_)
        local set_theme = require("styler").set_theme
        local win = vim.api.nvim_get_current_win()

        -- use default colorscheme instead of applying styler.nvim on floatwin
        -- because some UIs are composed of multiple windows and they should share the theme
        if vim.api.nvim_win_get_config(win).relative ~= "" then
            return
        end

        -- apply styler.nvim on active window
        set_theme(win, { colorscheme = ACTIVE_COLORSCHEME })

        -- apply styler.nvim on inactive windows
        for _, w in pairs(vim.api.nvim_tabpage_list_wins(0)) do
            if w ~= win then
                set_theme(w, { colorscheme = INACTIVE_COLORSCHEME })
            end
        end
    end,
})
