local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    --system
    {
        "github/copilot.vim",
        lazy = false,
    },
    { "kaepa3/swpclear" },
    { "simeji/winresizer" },
    { "vim-jp/vimdoc-ja", },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "kyazdani42/nvim-web-devicons" },
    },
    {
        "mattn/emmet-vim",
        ft = { "html", "typescript" },
        lazy = true,
    },
    { "lewis6991/gitsigns.nvim" },
    { "tpope/vim-fugitive" },
    -->system
    { "vim-skk/skkeleton" },
    --lsp
    "vim-denops/denops.vim",
    "prabirshrestha/vim-lsp",
    { "neovim/nvim-lspconfig" },
    "mattn/vim-lsp-settings",
    "hrsh7th/vim-vsnip",
    {
        "shougo/ddc.vim",
        dependencies = {
            "shougo/pum.vim",
            "shougo/ddc-ui-pum",
            "shougo/ddc-ui-native",
            "shougo/ddc-source-around",
            "shougo/ddc-source-lsp",
            "tani/ddc-fuzzy",
            "shun/ddc-source-vim-lsp",
            "uga-rosa/ddc-source-vsnip",
        },
    },
    {
        "williamboman/mason.nvim"
    },
    {
        "williamboman/mason-lspconfig.nvim"
    },
    -- amongst your other plugins
    { 'akinsho/toggleterm.nvim', version = "*", config = true },
    -- or
    { 'akinsho/toggleterm.nvim', version = "*", opts = { --[[ things you want to change go here]] } },
    -->lsp
    --cmd
    { "machakann/vim-sandwich" },
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup()
        end,
    },
    {
        "heavenshell/vim-jsdoc",
        event = "VeryLazy",
        ft = { "javascript", "typescript" },
    },
    -->cmd
    --disp
    { "nvim-treesitter/nvim-treesitter-context" },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate"
    },
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
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {},
        keys = {
            {
                "s",
                mode = { "n", "x", "o" },
                function()
                    -- default options: exact mode, multi window, all directions, with a backdrop
                    require("flash").jump()
                end,
                desc = "Flash",
            },
            {
                "S",
                mode = { "n", "o", "x" },
                function()
                    require("flash").treesitter()
                end,
                desc = "Flash Treesitter",
            },
            {
                "r",
                mode = "o",
                function()
                    require("flash").remote()
                end,
                desc = "Remote Flash",
            },
        },
    },
    {
        "folke/trouble.nvim",
        dependencies = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup()
        end
    },
    --style
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.5",
        dependencies = { { "nvim-lua/plenary.nvim" } },
    },
    { "EdenEast/nightfox.nvim" },
    { "folke/tokyonight.nvim" },
    { "folke/styler.nvim" },
    -->disp
})


require("p-conf/ddc")
require("p-conf/tree")
require("p-conf/lualine")
require("p-conf/gitsigns")
require("p-conf/notice")
require("p-conf/style")
require("p-conf/mason")

require("toggleterm").setup {}
