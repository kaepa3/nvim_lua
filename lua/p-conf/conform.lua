require("conform").setup({
    -- 保存時にフォーマットを実行する
    format_on_save = {
        -- LSPのフォーマット機能が使える場合はそちらを優先する (任意)
        lsp_fallback = true,
        -- 同期的にフォーマットを実行（非同期だと保存タイミングとずれることがあるため）
        async = false,
        -- フォーマットがタイムアウトするまでの時間
        timeout_ms = 500,
    },

    -- ファイルタイプごとのフォーマッタを指定
    formatters_by_ft = {
        -- Vueファイルには 'prettier' を使用
        vue = { "prettier" },

        -- 他のファイルタイプも同様に設定
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        lua = { "stylua" },
        go = { "goimports", "gofumpt" },
    },
})
