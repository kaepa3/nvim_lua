vim.opt.termguicolors = true
vim.opt.winblend = 0 -- ウィンドウの不透明度
vim.opt.pumblend = 0 -- ポップアップメニューの不透明度

require("nightfox").setup({
    options = {
        transparent = true,
    },
})
require("tokyonight").setup({
    options = {
        transparent = true,
        styles = {
            sidebars = "transparent",
            floats = "transparent",
        },
    },
})
--colorchg
BASE_COLORSCHEME = "nightfox"
ACTIVE_COLORSCHEME = "tokyonight"
INACTIVE_COLORSCHEME = "nordfox"

-- Apply colorscheme
vim.cmd("colorscheme " .. BASE_COLORSCHEME)
