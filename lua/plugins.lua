vim.cmd([[packadd packer.nvim]])

require("packer").startup(function()
    --general
    use("nvim-tree/nvim-web-devicons")
    use("wbthomason/packer.nvim")
    use("tpope/vim-fugitive")
    use("tpope/vim-repeat")
    use("unblevable/quick-scope")
    use({
        "folke/noice.nvim",
        config = function()
            require("noice").setup({
                -- add any options here
            })
        end,
        requires = {
            -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
            "MunifTanjim/nui.nvim",
            -- OPTIONAL:
            --   `nvim-notify` is only needed, if you want to use the notification view.
            --   If not available, we use `mini` as the fallback
            "rcarriga/nvim-notify",
        },
    })
    --common
    use({ "kaepa3/timer.nvim" })
    use({ "simeji/winresizer" })
    use({ "kaepa3/swpclear" })
    use({ "machakann/vim-sandwich" })
    use({
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup({})
        end,
    })
    use({
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
    })
    use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
    --style
    use({
        "nvim-telescope/telescope.nvim",
        tag = "0.1.0",
        requires = { { "nvim-lua/plenary.nvim" } },
    })
    use("EdenEast/nightfox.nvim")
    --lsp
    use("neovim/nvim-lspconfig")
    use({ "williamboman/mason.nvim" })
    use({ "williamboman/mason-lspconfig.nvim" })
    use({
        "williamboman/nvim-lsp-installer",
    })
    use({
        "hrsh7th/nvim-cmp",
        requires = {
            { "L3MON4D3/LuaSnip" },
            { "saadparwaiz1/cmp_luasnip" },
        },
    })
    use("hrsh7th/cmp-nvim-lsp")
    use({
        "jose-elias-alvarez/null-ls.nvim",
        requires = "nvim-lua/plenary.nvim",
    })
    use({
        "folke/trouble.nvim",
        requires = "kyazdani42/nvim-web-devicons",
        config = function()
            require("trouble").setup({
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            })
        end,
    })
    --html
    use({
        "mattn/emmet-vim",
        ft = "html",
        opt = true,
    })
    --markdown
    use("tyru/open-browser.vim")
    use("previm/previm")
end)
vim.cmd([[autocmd BufWritePost init.lua source <afile> | PackerCompile]])

require("nvim-autopairs").setup({
    disable_filetype = { "TelescopePrompt", "vim" },
})

--style
vim.cmd("colorscheme nightfox")
require("lualine").setup()

--lsp
require("p-conf/mason")
require("p-conf/null-ls")
require("p-conf/cmp")
require("p-conf/tree")
require("p-conf/qs")
require("p-conf/notice")

--> lsp
