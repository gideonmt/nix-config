-- Surround
require("nvim-surround").setup()

-- Marks
require("marks").setup({
   default_mappings = true,
   cyclic = true,
   force_write_shada = false,
   refresh_interval = 250,
   sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
   excluded_filetypes = {},
   bookmark_0 = {
      sign = "⚑",
      virt_text = "bookmark",
      annotate = false,
   },
   mappings = {}
})

-- Oil
require("oil").setup({
   default_file_explorer = true,
   columns = {
      "icon",
      "permissions",
      "size",
      "mtime",
   },
   buf_options = {
      buflisted = false,
      bufhidden = "hide",
   },
   win_options = {
      wrap = false,
      signcolumn = "no",
      cursorcolumn = false,
      foldcolumn = "0",
      spell = false,
      list = false,
      conceallevel = 3,
      concealcursor = "nvic",
   },
   delete_to_trash = false,
   skip_confirm_for_simple_edits = false,
   prompt_save_on_select_new_entry = true,
   cleanup_delay_ms = 2000,
   keymaps = {
      ["g?"] = "actions.show_help",
      ["<CR>"] = "actions.select",
      ["<C-s>"] = "actions.select_vsplit",
      ["<C-h>"] = "actions.select_split",
      ["<C-t>"] = "actions.select_tab",
      ["<C-p>"] = "actions.preview",
      ["<C-c>"] = "actions.close",
      ["<C-l>"] = "actions.refresh",
      ["-"] = "actions.parent",
      ["_"] = "actions.open_cwd",
      ["`"] = "actions.cd",
      ["~"] = "actions.tcd",
      ["gs"] = "actions.change_sort",
      ["gx"] = "actions.open_external",
      ["g."] = "actions.toggle_hidden",
      ["g\\"] = "actions.toggle_trash",
   },
   use_default_keymaps = true,
   view_options = {
      show_hidden = false,
      is_hidden_file = function(name, bufnr)
         return vim.startswith(name, ".")
      end,
      is_always_hidden = function(name, bufnr)
         return false
      end,
      sort = {
         { "type", "asc" },
         { "name", "asc" },
      },
   },
   float = {
      padding = 2,
      max_width = 0,
      max_height = 0,
      border = "rounded",
      win_options = {
         winblend = 0,
      },
   },
   preview = {
      max_width = 0.9,
      min_width = { 40, 0.4 },
      width = nil,
      max_height = 0.9,
      min_height = { 5, 0.1 },
      height = nil,
      border = "rounded",
      win_options = {
         winblend = 0,
      },
   },
   progress = {
      max_width = 0.9,
      min_width = { 40, 0.4 },
      width = nil,
      max_height = { 10, 0.9 },
      min_height = { 5, 0.1 },
      height = nil,
      border = "rounded",
      minimized_border = "none",
      win_options = {
         winblend = 0,
      },
   },
})

-- Venn (diagram drawing)
function _G.Toggle_venn()
    local venn_enabled = vim.inspect(vim.b.venn_enabled)
    if venn_enabled == "nil" then
        vim.b.venn_enabled = true
        vim.cmd[[setlocal ve=all]]
        vim.api.nvim_buf_set_keymap(0, "n", "J", "<C-v>j:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "K", "<C-v>k:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "L", "<C-v>l:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "n", "H", "<C-v>h:VBox<CR>", {noremap = true})
        vim.api.nvim_buf_set_keymap(0, "v", "f", ":VBox<CR>", {noremap = true})
    else
        vim.cmd[[setlocal ve=]]
        vim.api.nvim_buf_del_keymap(0, "n", "J")
        vim.api.nvim_buf_del_keymap(0, "n", "K")
        vim.api.nvim_buf_del_keymap(0, "n", "L")
        vim.api.nvim_buf_del_keymap(0, "n", "H")
        vim.api.nvim_buf_del_keymap(0, "v", "f")
        vim.b.venn_enabled = nil
    end
end

vim.api.nvim_set_keymap('n', '<leader>V', ":lua Toggle_venn()<CR>", { noremap = true})
