vim.cmd[[packadd packer.nvim]]

require'packer'.startup(function()
    use 'wbthomason/packer.nvim'
    use'tpope/vim-fugitive'
    use'tpope/vim-repeat'
    --style
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use "EdenEast/nightfox.nvim"
    --lsp
    use 'neovim/nvim-lspconfig'
    use {'williamboman/mason.nvim'}
    use {
        "williamboman/nvim-lsp-installer",
    }
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    --html
    use {
        'mattn/emmet-vim',
        ft='html',
        opt=true
    }

end)
vim.cmd([[autocmd BufWritePost init.lua source <afile> | PackerCompile]])

--style
vim.cmd("colorscheme nightfox")

--lsp
require("mason").setup()
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers {
    function (server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup {
            on_attach = on_attach
        }
    end,
}
-- 3. completion (hrsh7th/nvim-cmp)
local cmp = require("cmp")
cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    sources = {
        { name = "nvim_lsp" },
        -- { name = "buffer" },
        -- { name = "path" },
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ['<C-l>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm { select = true },
    }),
    experimental = {
        ghost_text = true,
    },
})
--> lsp
