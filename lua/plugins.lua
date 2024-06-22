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
    { "kaepa3/swpclear" },
    { "simeji/winresizer" },
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
    --lsp
    "vim-denops/denops.vim",
    "prabirshrestha/vim-lsp",
    { "neovim/nvim-lspconfig" },
    "mattn/vim-lsp-settings",
    "hrsh7th/vim-vsnip",
    {
        "Shougo/ddc.vim",
        dependencies = {
            "Shougo/pum.vim",
            "Shougo/ddc-ui-pum",
            "Shougo/ddc-ui-native",
            "Shougo/ddc-source-around",
            "Shougo/ddc-source-lsp",
            "tani/ddc-fuzzy",
            "shun/ddc-source-vim-lsp",
            "uga-rosa/ddc-source-vsnip",
        },
    },
    -->lsp
    --cmd
    { "machakann/vim-sandwich" },
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup()
        end,
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
        end,
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

local lspconfig = require('lspconfig')
lspconfig.pyright.setup {}
lspconfig.tsserver.setup {}
lspconfig.ruby_lsp.setup {}
lspconfig.gopls.setup {}
lspconfig.rust_analyzer.setup {}
lspconfig.lua_ls.setup({
    settings = {
        Lua = {
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = { 'vim' },
            },
        },
    }
})

lspconfig.efm.setup {
    filetypes = {
        "python"
    },
    init_options = { documentFormatting = true },
    settings = {
        rootMarkers = { ".git/" },
        languages = {
            python = {
                {
                    formatCommand = "black --fast -l 120 -",
                    formatStdin = true,
                }
            }
        }
    }
}

require("p-conf/ddc")
require("p-conf/tree")
require("p-conf/lualine")
require("p-conf/gitsigns")
require("p-conf/notice")
require("p-conf/style")
