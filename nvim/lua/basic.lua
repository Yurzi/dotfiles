-- cursor reset after quit
vim.cmd("autocmd VimLeavePre * silent set guicursor=a:ver25")

-- 使得O新增行不会继承上行注释
vim.cmd("autocmd FileType * setlocal formatoptions-=o")

-- providers
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- utf-8
vim.g.encoding = "UTF-8"
vim.o.fileencoding = "utf-8"
vim.o.fileencodings = "ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1"

-- shell
-- vim.o.shell = "pwsh"

-- 使用相对行号
vim.wo.number = true
vim.wo.relativenumber = true

-- 高亮当前行和列
vim.wo.cursorline = false
vim.wo.cursorcolumn = true
vim.o.scrolloff = 8

-- 显示左侧图标显示列
vim.wo.signcolumn = "yes"

-- 右参考线
vim.wo.colorcolumn = "80"

-- 缩进4个空格等于一个Tab
vim.o.tabstop = 2
vim.bo.tabstop = 2
vim.o.softtabstop = 2

-- 空格替代Tab
vim.o.expandtab = true
vim.bo.expandtab = true

-- 缩进相关 '>>' '<<'
vim.o.shiftround = true
vim.o.shiftwidth = 2
vim.bo.shiftwidth = 2

-- 自动缩进
vim.o.autoindent = true
vim.bo.autoindent = true
vim.o.smartindent = true

-- 大小写敏感
vim.o.ignorecase = true
vim.o.smartcase = true

-- 搜索高亮
vim.o.hlsearch = true

-- 边输入边搜索
vim.o.incsearch = true

-- 自动加载文件
vim.o.autoread = true
vim.bo.autoread = true

-- 自动折行
vim.wo.wrap = true

-- 光标上下保留
vim.o.scrolloff = 8
-- 光标在行首尾时<Left><Right>可以跳到下一行
-- vim.o.whichwrap = '<,>,[,]'

-- 允许隐藏被修改过的buffer
vim.o.hidden = true

-- 鼠标支持
vim.o.mouse = "a"

-- smaller updatetime
vim.o.updatetime = 600

-- 设置 timeoutlen 为等待键盘快捷键连击时间500毫秒，可根据需要设置
vim.o.timeoutlen = 1000

-- split window 从下边和右边出现
vim.o.splitbelow = true
vim.o.splitright = true

-- 自动补全不自动选中
vim.g.completeopt = "menu,menuone,noselect,noinsert"

-- 样式
vim.o.termguicolors = true
vim.opt.termguicolors = true

-- 不可见字符的显示，这里只把空格显示为一个点
vim.o.list = true
vim.o.listchars = "space:·"

-- 补全增强
vim.o.wildmenu = true

-- Dont' pass messages to |ins-completin menu|
vim.o.shortmess = vim.o.shortmess .. "c"

-- 补全最多显示10行
vim.o.pumheight = 10

-- 永远显示 tabline
vim.o.showtabline = 2

-- 使用增强状态栏插件后不再需要 vim 的模式提示
vim.o.showmode = false
