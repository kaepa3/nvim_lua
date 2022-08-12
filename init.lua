require'plugins'

--config--vim
vim.o.virtualedit=block
--
vim.o.number = true
vim.o.laststatus=2
--
--search
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true



vim.o.expandtab = true
vim.o.tabstop=4
vim.o.shiftwidth=4
vim.o.smartindent = true
vim.o.title = true
vim.o.showmatch = true

vim.o.wildmenu = true

-- カレント行ハイライト
vim.o.cursorline = true

-- マウス有効
vim.o.mouse=a

-- theme
vim.o.list  = true


-- クリップボード
vim.o.clipboard = "unnamedplus"
--syntax on
-- 行末のスペースを可視化
--vim.o.listchars=tab:^\ ,trail:~
--vim.o.listchars=tab:»\ ,trail:-,extends:»,precedes:«,nbsp:% 
-- インデント設定
--filetype plugin indent on
---------------------->configvim

require'keymapping'
