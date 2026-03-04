local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Window navigation
map("n", "<C-h>", "<C-w>h", opts)
map("n", "<C-j>", "<C-w>j", opts)
map("n", "<C-k>", "<C-w>k", opts)
map("n", "<C-l>", "<C-w>l", opts)

-- Tab navigation
map("n", "<Leader>tn", ":tabnew<CR>", opts)
map("n", "<Leader>tc", ":tabclose<CR>", opts)
map("n", "<Leader>to", ":tabonly<CR>", opts)
map("n", "<Leader>h", ":tabprevious<CR>", opts)
map("n", "<Leader>l", ":tabnext<CR>", opts)

-- Buffer navigation
map("n", "[b", ":bprevious<CR>", opts)
map("n", "]b", ":bnext<CR>", opts)
map("n", "<Leader>bd", ":bdelete<CR>", opts)
map("n", "<Leader>ba", ":%bdelete|edit#|bdelete#<CR>", opts)

-- File operations
map("n", "<Leader>w", ":write<CR>", opts)
map("n", "<Leader>q", ":quit<CR>", opts)
map("n", "<Leader>Q", ":qall<CR>", opts)
map("n", "<Leader>x", ":wq<CR>", opts)

-- Better indenting
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Move lines
map("n", "<A-j>", ":m .+1<CR>==", opts)
map("n", "<A-k>", ":m .-2<CR>==", opts)
map("v", "<A-j>", ":m '>+1<CR>gv=gv", opts)
map("v", "<A-k>", ":m '<-2<CR>gv=gv", opts)

-- Quickfix list
map("n", "[q", ":cprevious<CR>", opts)
map("n", "]q", ":cnext<CR>", opts)
map("n", "[Q", ":cfirst<CR>", opts)
map("n", "]Q", ":clast<CR>", opts)
map("n", "<Leader>co", ":copen<CR>", opts)
map("n", "<Leader>cc", ":cclose<CR>", opts)

-- Center screen after jumps
map("n", "n", "nzzzv", opts)
map("n", "N", "Nzzzv", opts)
map("n", "<C-j>", "<C-d>zz", opts)
map("n", "<C-k>", "<C-u>zz", opts)

-- Join lines without moving cursor
map("n", "<Leader>J", "mzJ`z", opts)

-- Clear highlights
map("n", "<Esc>", ":nohlsearch<CR>", opts)

-- Quick source current file
map("n", "<Leader>s", ":source %<CR>", opts)

-- Navigate to config
map("n", "<Leader>v", ":cd ~/.config/nvim/<CR>:Telescope find_files<CR>", opts)

-- Oil file explorer
map("n", "-", ":Oil<CR>", opts)

-- LSP keymaps (set in LSP config when server attaches)
map("n", "<Leader>d", vim.diagnostic.open_float, opts)
map("n", "[d", vim.diagnostic.goto_prev, opts)
map("n", "]d", vim.diagnostic.goto_next, opts)
