require("plugins")

--config--vim
vim.o.virtualedit = block
vim.o.number = true
vim.o.laststatus = 2

--search
vim.o.hlsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.expandtab = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.smartindent = true
vim.o.title = true
vim.o.showmatch = true

vim.o.wildmenu = true

-- カレント行ハイライト
vim.o.cursorline = true

--  ヘルプ
vim.opt.helplang = 'ja'

-- マウス有効
vim.cmd("set mouse=a")

-- theme
vim.o.list = true

-- クリップボード
vim.o.clipboard = "unnamedplus"

vim.cmd([[autocmd BufWritePre * lua vim.lsp.buf.format()]])

-- ステータスカラム
vim.cmd("set nu rnu")
vim.cmd(
    'let &stc=\'%s%#NonText#%{&nu?v:lnum:""}%=%{&rnu&&(v:lnum%2)?"\\ ".v:relnum:""}%#LineNr#%{&rnu&&!(v:lnum%2)?"\\ ".v:relnum:""}｜\''
)

if vim.fn.has('mac') == 1 then
elseif vim.fn.has('win32') or vim.fn.has('win64') then
    print("Windows detected, loading win module")
    require("win")
end

-- denops
vim.cmd("set runtimepath^=~/dps-helloworld")
-- 行末のスペースを可視化
--vim.o.listchars=tab:^\ ,trail:~
--vim.o.listchars=tab:»\ ,trail:-,extends:»,precedes:«,nbsp:%
-- インデント設定
---------------------->configvim
require("keymapping")
