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
    },
    { "EdenEast/nightfox.nvim" },
    { "folke/tokyonight.nvim" },
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
        "yetone/avante.nvim",
        -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
        -- ⚠️ must add this setting! ! !
        build = vim.fn.has("win32") ~= 0
                and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
            or "make",
        event = "VeryLazy",
        version = false, -- Never set this value to "*"! Never!
        ---@module 'avante'
        ---@type avante.Config
        opts = {
            -- add any opts here
            -- this file can contain specific instructions for your project
            instructions_file = "avante.md",
            -- for example
            provider = "gemini",
            providers = {
                claude = {
                    endpoint = "https://api.anthropic.com",
                    model = "claude-sonnet-4-20250514",
                    timeout = 30000, -- Timeout in milliseconds
                    extra_request_body = {
                        temperature = 0.75,
                        max_tokens = 20480,
                    },
                },
                gemini = {
                    --model = "gemini-2.5-flash", -- または "gemini-1.5-pro"
                    model = "gemini-2.5-pro",
                    timeout = 30000,
                    api_key_name = "GEMINI_API_KEY",
                    temperature = 0,
                    max_tokens = 4096,
                },
                moonshot = {
                    endpoint = "https://api.moonshot.ai/v1",
                    model = "kimi-k2-0711-preview",
                    timeout = 30000, -- Timeout in milliseconds
                    extra_request_body = {
                        temperature = 0.75,
                        max_tokens = 32768,
                    },
                },
            },
        },
        dependencies = {
            "nvim-lua/plenary.nvim",
            "MunifTanjim/nui.nvim",
            "nvim-mini/mini.pick", -- for file_selector provider mini.pick
            "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
            "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
            "ibhagwan/fzf-lua", -- for file_selector provider fzf
            "stevearc/dressing.nvim", -- for input provider dressing
            "folke/snacks.nvim", -- for input provider snacks
            "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
            "zbirenbaum/copilot.lua", -- for providers='copilot'
            {
                -- support for image pasting
                "HakonHarnes/img-clip.nvim",
                event = "VeryLazy",
                opts = {
                    -- recommended settings
                    default = {
                        embed_image_as_base64 = false,
                        prompt_for_file_name = false,
                        drag_and_drop = {
                            insert_mode = true,
                        },
                        -- required for Windows users
                        use_absolute_path = true,
                    },
                },
            },
            {
                -- Make sure to set this up properly if you have lazy=true
                "MeanderingProgrammer/render-markdown.nvim",
                opts = {
                    file_types = { "markdown", "Avante" },
                },
                ft = { "markdown", "Avante" },
            },
        },
    },
})
require("oil").setup()

require("p-conf/style")
