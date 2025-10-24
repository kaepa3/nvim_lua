require("plugins")

--config--vim
vim.opt.virtualedit = block
vim.opt.number = true
vim.opt.laststatus = 2

--search
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.title = true
vim.opt.showmatch = true

vim.opt.wildmenu = true

-- カレント行ハイライト
vim.opt.cursorline = true

--  ヘルプ
vim.opt.helplang = 'ja'

-- マウス有効
vim.opt.mouse = 'a'

-- theme
vim.opt.list = true

-- クリップボード
vim.opt.clipboard = "unnamedplus"

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
--vim.opt.listchars=tab:^\ ,trail:~
--vim.opt.listchars=tab:»\ ,trail:-,extends:»,precedes:«,nbsp:%
-- インデント設定
---------------------->configvim
require("keymapping")
