local o = vim.opt

-- UI
o.number = true
o.relativenumber = true
o.cursorline = true
o.cursorlineopt = "number"
o.scrolloff = 10
o.splitkeep = "screen"
o.splitright = true
o.splitbelow = true
o.signcolumn = "yes"
o.colorcolumn = "80"

-- Search
o.ignorecase = true
o.smartcase = true
o.hlsearch = false

-- Indentation
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4
o.expandtab = true
o.smartindent = true

-- Files
o.swapfile = false
o.undofile = true
o.backup = false
o.writebackup = false

-- Performance
o.updatetime = 250
o.timeoutlen = 300

-- Disable mouse completely
o.mouse = ""

-- Completion
o.completeopt = "menu,menuone,noselect"

-- Leader keys
vim.g.mapleader = " "
vim.g.maplocalleader = " "
