-- Gitsigns
require("gitsigns").setup({
   signs = {
      add = { text = "│" },
      change = { text = "│" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
   },
   on_attach = function(bufnr)
      local gs = package.loaded.gitsigns
      local map = function(mode, l, r, opts)
         opts = opts or {}
         opts.buffer = bufnr
         vim.keymap.set(mode, l, r, opts)
      end
      
      -- Navigation
      map("n", "]c", function()
         if vim.wo.diff then return "]c" end
         vim.schedule(function() gs.next_hunk() end)
         return "<Ignore>"
      end, { expr = true, desc = "Next git hunk" })
      
      map("n", "[c", function()
         if vim.wo.diff then return "[c" end
         vim.schedule(function() gs.prev_hunk() end)
         return "<Ignore>"
      end, { expr = true, desc = "Previous git hunk" })
      
      -- Actions
      map("n", "<Leader>gs", gs.stage_hunk, { desc = "Stage hunk" })
      map("n", "<Leader>gr", gs.reset_hunk, { desc = "Reset hunk" })
      map("n", "<Leader>gS", gs.stage_buffer, { desc = "Stage buffer" })
      map("n", "<Leader>gu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
      map("n", "<Leader>gR", gs.reset_buffer, { desc = "Reset buffer" })
      map("n", "<Leader>gp", gs.preview_hunk, { desc = "Preview hunk" })
      map("n", "<Leader>gb", function() gs.blame_line({ full = true }) end, { desc = "Blame line" })
      map("n", "<Leader>gd", gs.diffthis, { desc = "Diff this" })
   end,
})

-- Fugitive keybindings
vim.keymap.set("n", "<Leader>gg", ":Git<CR>", { desc = "Git status" })
vim.keymap.set("n", "<Leader>gc", ":Git commit<CR>", { desc = "Git commit" })
vim.keymap.set("n", "<Leader>gP", ":Git push<CR>", { desc = "Git push" })
vim.keymap.set("n", "<Leader>gl", ":Git pull<CR>", { desc = "Git pull" })
