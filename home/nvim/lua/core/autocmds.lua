local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Highlight on yank
autocmd("TextYankPost", {
   group = augroup("HighlightYank", { clear = true }),
   callback = function()
      vim.highlight.on_yank({ timeout = 200 })
   end,
})

-- Disable auto comment
autocmd("BufEnter", {
   group = augroup("DisableAutoComment", { clear = true }),
   callback = function()
      vim.opt.formatoptions:remove({ "c", "r", "o" })
   end,
})

-- Spell check for markdown and text
autocmd("FileType", {
   group = augroup("MarkdownSpell", { clear = true }),
   pattern = { "markdown", "text" },
   callback = function()
      vim.opt_local.spell = true
   end,
})

-- Run programs by filetype
local RunGroup = augroup("QuickRun", { clear = true })

autocmd("FileType", {
   group = RunGroup,
   pattern = "cpp",
   callback = function()
      vim.keymap.set("n", "<Leader>r", ":split | kitty ./a.out<CR>", { buffer = true })
   end,
})

autocmd("FileType", {
   group = RunGroup,
   pattern = "go",
   callback = function()
      vim.keymap.set("n", "<Leader>r", ":split | kitty go run %<CR>", { buffer = true })
   end,
})

autocmd("FileType", {
   group = RunGroup,
   pattern = "python",
   callback = function()
      vim.keymap.set("n", "<Leader>r", ":split | kitty python3 %<CR>", { buffer = true })
   end,
})
