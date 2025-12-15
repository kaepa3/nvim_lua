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
    {
        "stevearc/oil.nvim",
        ---@module 'oil'
        ---@type oil.SetupOpts
        opts = {},
        -- Optional dependencies
        dependencies = { { "nvim-mini/mini.icons", opts = {} } },
        dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
        -- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
        lazy = false,
    },
    { "kaepa3/swpclear" },
    { "simeji/winresizer" },
    { "vim-jp/vimdoc-ja" },
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
    { "neovim/nvim-lspconfig" },
    "hrsh7th/vim-vsnip",
    {
        "shougo/ddc.vim",
        dependencies = {
            "shougo/pum.vim",
            "shougo/ddc-ui-pum",
            "shougo/ddc-ui-native",
            "shougo/ddc-source-around",
            "shougo/ddc-source-lsp",
            "Shougo/ddc-filter-sorter_rank",
            "Shougo/ddc-matcher_head",
            "tani/ddc-fuzzy",
            "uga-rosa/ddc-source-vsnip",
        },
    },
    {
        "williamboman/mason.nvim",
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
        },
    },
    {
        "stevearc/conform.nvim",
        opts = {},
    },
    -- amongst your other plugins
    { "akinsho/toggleterm.nvim", version = "*", config = true },
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
        build = ":TSUpdate",
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
    {
        "scalameta/nvim-metals",
        -- 必須の依存プラグイン
        dependencies = {
            "nvim-lua/plenary.nvim",
            "mfussenegger/nvim-dap", -- デバッグ機能を使いたい場合
        },
        -- このプラグインは .scala, .sbt, .java, .kotlin ファイルで有効化
        ft = { "scala", "sbt", "java", "kotlin" },
        -- 初期化設定
        config = function()
            local metals = require("metals")
            local metals_config = metals.bare_config()

            -- ここで設定をカスタマイズできます
            -- 例: on_attachに関数を設定
            metals_config.on_attach = function(client, bufnr)
                -- ここに定義ジャンプなどのキーマッピングを設定
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr })
                vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = bufnr })
                -- ... その他
            end

            -- Java/Kotlinでデバッグ機能を使うために必要
            metals_config.init_options.enableFullptc = true
            metals_config.init_options.enableStripMargin = true

            -- nvim-dapとの連携
            metals_config.dap = {
                adapter_properties = {
                    host = "127.0.0.1",
                    port = 5005,
                },
            }

            -- Metalsを起動
            metals.initialize_or_attach(metals_config)
        end,
    },
})

require("p-conf/ddc")
require("p-conf/tree")
require("p-conf/lualine")
require("p-conf/gitsigns")
require("p-conf/notice")
require("p-conf/style")
require("p-conf/mason")
require("p-conf/conform")
require("toggleterm").setup({})
