local opt = vim.opt -- for conciseness

-- Line numbers (relative)
opt.nu = true
opt.relativenumber = true

-- Tab spaces
opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.smartindent = true

-- Line wrap
opt.wrap = false

-- Backups and swapfiles. Give access to undo tree to undofile
opt.swapfile = false
opt.backup = false
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = false

-- Improved search highlighting
opt.hlsearch = false
opt.incsearch = true
--opt.ignorecase = true
opt.smartcase = true

opt.termguicolors = true

-- Keep cursor within 8 lines when scrolling
opt.scrolloff = 6

-- Time for vim to wait after you stop typing to trigger a plugin
opt.updatetime = 1000

-- leader timeout time in ms
opt.timeoutlen = 1250

-- color column
opt.colorcolumn = "100"

-- map leader to blank space
vim.g.mapleader = " "

-- split windows
opt.splitright = true
opt.splitbelow = true

opt.cursorline = true
