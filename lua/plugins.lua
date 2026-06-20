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
        dependencies = { { "nvim-mini/mini.icons", opts = {} } },
        event = "VeryLazy",
        lazy = false,
        config = function()
            require("oil").setup()
            vim.keymap.set("n", "<leader>o", "<cmd>Oil<CR>", {})
        end,
    },
    { "kaepa3/swpclear" },
    { "simeji/winresizer" },
    { "vim-jp/vimdoc-ja" },
    {
        "mattn/emmet-vim",
        ft = { "html", "typescript" },
        lazy = true,
    },
    {
        "lewis6991/gitsigns.nvim",
        event = "VeryLazy",
        config = function()
            require("p-conf/gitsigns")
        end,
    },
    { "tpope/vim-fugitive" },
    -->system
    --lsp
    {
        "vim-denops/denops.vim",
        event = "VeryLazy",
    },
    { "neovim/nvim-lspconfig" },
    {
        "saghen/blink.cmp",
        dependencies = "rafamadriz/friendly-snippets",

        -- release版を使うことで、ビルド済みバイナリをダウンロードします
        version = "*",

        ---@module 'blink.cmp'
        opts = {
            -- キーマップの設定: 'default' にすると一般的なキー操作になります
            keymap = {
                preset = "default",
                ["<CR>"] = { "accept", "fallback" },
                ["<Tab>"] = { "snippet_forward", "fallback" },
                ["<S-Tab>"] = { "snippet_backward", "fallback" },
            },

            appearance = {
                -- Nerd Fontアイコンを使う場合
                use_nvim_cmp_as_default = true,
                nerd_font_variant = "mono",
            },

            -- 補完ソースの定義
            sources = {
                default = { "lsp", "path", "snippets", "buffer" },
            },

            -- シグネチャヘルプ（関数の引数表示）もこれ一つで賄えます
            signature = { enabled = true },
        },
        opts_extend = { "sources.default" },
        event = "InsertEnter",
    },
    {
        "williamboman/mason.nvim",
        config = function()
            require("p-conf/mason")
        end,
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
        config = function()
            require("p-conf/conform")
        end,
    },
    -->lsp
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        ---@type snacks.Config
        opts = {
            -- Toggletermの代わり
            terminal = { enabled = true },
            -- ファイルのりネームや削除時の通知など
            rename = { enabled = true },
            -- GitのBlame表示など
            git = { enabled = true },
            -- 起動画面（Dashboard）もこれにできる
            dashboard = { enabled = true },
        },
        keys = {
            -- ターミナルをトグルするキー設定例
            {
                "<c-\\>",
                function()
                    Snacks.terminal()
                end,
                desc = "Toggle Terminal",
            },
        },
    },
    --cmd
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = true,
    },
    {
        "windwp/nvim-autopairs",
        config = function()
            require("nvim-autopairs").setup()
        end,
    },
    {
        "danymat/neogen",
        dependencies = "nvim-treesitter/nvim-treesitter",
        cmd = "Neogen",
        config = function()
            require("p-conf/tree")
        end,
        event = { "BufReadPost", "BufNewFile" }, -- ファイルを開いた時に読み込む
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
        config = function()
            require("p-conf/lualine")
        end,
    },
    {
        "folke/noice.nvim",
        dependencies = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
        config = function()
            require("p-conf/notice")
        end,
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
        config = function()
            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
            vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
            vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
            vim.keymap.set("n", "<leader>fw", builtin.grep_string, {})
            vim.keymap.set("n", "<leader>fr", builtin.oldfiles, {})
        end,
    },
    { "EdenEast/nightfox.nvim" },
    {
        "folke/tokyonight.nvim",
        config = function()
            require("p-conf/style")
        end,
    },
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
    {
        "folke/sidekick.nvim",
        -- Sidekickのコマンドが叩かれた時、または設定したキーを押した時に遅延ロード
        cmd = "Sidekick",
        keys = {
            { "<leader>aa", "<cmd>Sidekick cli toggle<cr>", desc = "Toggle AI Chat (Antigravity)" },
            { "<leader>as", "<cmd>Sidekick cli send<cr>", mode = { "n", "v" }, desc = "Send to AI" },
        },
        opts = {
            -- 1. AIへの指示（システムプロンプト）を日本語で固定する
            system_prompt = "あなたは優秀なエンジニアです。回答やコードの解説、提案はすべて、必ず簡潔でわかりやすい日本語で行ってください。生成するコードコメントも日本語にしてください。",

            -- 2. ターミナル経由でAntigravityを呼び出す設定
            cli = {
                default = "antigravity", -- デフォルトで使うツールを指定
                tools = {
                    antigravity = {
                        cmd = { "agy" }, -- ターミナルから叩くAntigravityのコマンド名
                    },
                },
            },
        },
    },
})
