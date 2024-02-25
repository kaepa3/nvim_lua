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
    { "lewis6991/gitsigns.nvim" },
    { "kaepa3/timer.nvim" },
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
    --style
    {
        "nvim-telescope/telescope.nvim",
        version = "0.1.0",
        dependencies = { { "nvim-lua/plenary.nvim" } },
    },
    { "EdenEast/nightfox.nvim" },
    { "folke/tokyonight.nvim" },
    { "folke/styler.nvim" },
    --lsp
    {
        "Shougo/ddc.vim",
        dependencies = {
            "Shougo/ddc-ui-native",
            "Shougo/ddc-source-around",
            "Shougo/ddc-source-lsp",
            "tani/ddc-fuzzy",
            "shun/ddc-source-vim-lsp",
            "uga-rosa/ddc-source-vsnip",
        },
    },
    { "mattn/vim-lsp-settings" },
    { "hrsh7th/vim-vsnip" },
    { "jose-elias-alvarez/null-ls.nvim" },
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
        ft = { "html", "typescript" },
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
local function show_macro_recording()
    local recording_register = vim.fn.reg_recording()
    if recording_register == "" then
        return ""
    else
        return "Recording @" .. recording_register
    end
end

local lsp_names = function()
    local clients = {}
    for _, client in ipairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
        if client.name == "null-ls" then
            local sources = {}
            for _, source in ipairs(require("null-ls.sources").get_available(vim.bo.filetype)) do
                table.insert(sources, source.name)
            end
            table.insert(clients, "null-ls(" .. table.concat(sources, ", ") .. ")")
        else
            table.insert(clients, "1:" .. client.name)
        end
    end
    return " " .. table.concat(clients, ", ")
end
require("lualine").setup({
    options = {
        icons_enabled = true,
    },
    sections = {
        lualine_b = {
            {
                "macro-recording",
                fmt = show_macro_recording,
            },
        },
        lualine_x = { lsp_names },
    },
})
require("nvim-web-devicons").setup({
    color_icons = true,
    default = true,
})
----lsp
require("p-conf/null-ls")
require("p-conf/tree")
require("p-conf/notice")
require("p-conf/style")
--> lsp
require("gitsigns").setup({
    signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
    },
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
        follow_files = true,
    },
    attach_to_untracked = true,
    current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
    },
    current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000, -- Disable if file is longer than this (in lines)
    preview_config = {
        -- Options passed to nvim_open_win
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
    },
    yadm = {
        enable = false,
    },
})
