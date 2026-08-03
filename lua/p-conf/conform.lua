require("conform").setup({
    -- 保存時にフォーマットを実行する
    format_on_save = {
        -- LSPのフォーマットをフォールバックとして使用する
        lsp_format = "fallback",
        -- タイムアウト設定（この指定で自動的に同期実行になります）
        timeout_ms = 1000,
    },

    -- ファイルタイプごとのフォーマッタを指定
    formatters_by_ft = {
        vue = { "prettier" },
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
