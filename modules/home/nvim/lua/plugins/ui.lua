-- Colorscheme
vim.cmd.colorscheme("oxocarbon")
vim.opt.background = "dark"

-- Customize highlights
vim.api.nvim_create_autocmd("ColorScheme", {
   pattern = "*",
   callback = function()
      vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#b4befe" })
      vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = "#b4befe" })
      vim.api.nvim_set_hl(0, "IblScope", { fg = "#b4befe" })
   end,
})

-- Lualine
require("lualine").setup({
   options = {
      theme = {
         normal = { c = { fg = "#be95ff" } },
         inactive = { c = { fg = "#be95ff" } },
      },
      section_separators = "",
      component_separators = { left = "──", right = "──" },
      globalstatus = true,
   },
   sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {
         { "branch", icon = "", color = { fg = "#be95ff" } },
         { "diff" },
         { "diagnostics", symbols = { error = " ", warn = " ", info = " ", hint = " " } },
         "%=",
         { "filetype", colored = false, icon_only = true, separator = "∙" },
         { "filename", path = 1, symbols = { modified = "●" }, color = { fg = "#be95ff" } },
      },
      lualine_x = {},
      lualine_y = {},
      lualine_z = { { "progress", color = { fg = "#be95ff" } } },
   },
})

vim.opt.showmode = false
vim.opt.fillchars = { stl = "─", stlnc = "─" }

-- Bufferline
require("bufferline").setup({
   options = {
      separator_style = "slant",
      mode = "tabs",
      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(count, level)
         local icon = level:match("error") and " " or " "
         return " " .. icon .. count
      end,
   },
})

-- Indent blankline
require("ibl").setup({
   scope = {
      enabled = true,
   },
})

-- Notify
vim.notify = require("notify")
require("notify").setup({
   background_colour = "#000000",
   fps = 30,
   render = "default",
   timeout = 3000,
   top_down = true,
})

-- Colorizer
require("colorizer").setup()

-- Cursorline
require("nvim-cursorline").setup({
   cursorword = {
      enable = true,
      min_length = 3,
      hl = { underline = true },
   },
   cursorline = { enable = false },
})
