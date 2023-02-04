require("p-conf/qs")

local lazypath = vim.fn.stdpath("data") .. "~/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", lazypath })
    vim.fn.system({ "git", "-C", lazypath, "checkout", "tags/stable" })
end

vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
    { "lewis6991/impatient.nvim" },
    { "tpope/vim-fugitive" },
    { "tpope/vim-repeat" },
    { "unblevable/quick-scope" },
    --common
    { "vim-denops/denops.vim" },
    { "kaepa3/timer.nvim" },
    { "kaepa3/deepler.nvim" },
    { "kaepa3/cgpt.nvim" },
    { "kaepa3/mecaber.nvim" },
    { "simeji/winresizer" },
    { "kaepa3/swpclear" },
    { "machakann/vim-sandwich" },
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup()
        end,
    },
    { "nvim-treesitter/nvim-treesitter-context" },
    { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "kyazdani42/nvim-web-devicons" },
    },
    {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
    },
    --style
    {
        "nvim-telescope/telescope.nvim",
        version = "0.1.0",
        dependencies = { { "nvim-lua/plenary.nvim" } },
    },
    { "EdenEast/nightfox.nvim" },
    { "folke/tokyonight.nvim" },
    { "folke/styler.nvim" },
    --ls
    { "neovim/nvim-lspconfig" },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },
    {
        "williamboman/nvim-lsp-installer",
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            { "L3MON4D3/LuaSnip" },
            { "saadparwaiz1/cmp_luasnip" },
        },
    },
    { "hrsh7th/cmp-nvim-lsp" },
    {
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = "nvim-lua/plenary.nvim",
    },
    {
        "folke/trouble.nvim",
        dependencies = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup()
        end,
    },
    --html
    {
        "mattn/emmet-vim",
        ft = "html",
        lazy = true,
    },
    --markdown
    { "tyru/open-browser.vim", ft = "markdown", lazy = true },
    { "previm/previm", ft = "markdown", lazy = true },
})
require("impatient")

require("nvim-autopairs").setup({
    disable_filetype = { "TelescopePrompt", "vim" },
})

require("lualine").setup({
    options = {
        icons_enabled = true,
    },
})
require("nvim-web-devicons").setup({
    color_icons = true,
    default = true,
})
--lsp
require("p-conf/mason")
require("p-conf/null-ls")
require("p-conf/cmp")
require("p-conf/tree")
require("p-conf/notice")
require("p-conf/style")

--> lsp
