local cmd = vim.api.nvim_create_user_command

-- Convert tabs to spaces
cmd("ConvertTabs", function()
   vim.cmd([[%s/^\( \{2}\)\+/\=repeat(' ', len(submatch(0)) * 2)/g | noh]])
end, {})

-- Quick build/make
cmd("Make", function()
   vim.cmd("make")
end, {})

-- Format buffer
cmd("Format", function()
   vim.lsp.buf.format({ async = true })
end, {})

-- Toggle diagnostics
local diagnostics_active = true
cmd("DiagnosticsToggle", function()
   diagnostics_active = not diagnostics_active
   if diagnostics_active then
      vim.diagnostic.enable()
      vim.notify("Diagnostics enabled", vim.log.levels.INFO)
   else
      vim.diagnostic.disable()
      vim.notify("Diagnostics disabled", vim.log.levels.INFO)
   end
end, {})

-- Utility function for printing lua tables
_G.P = function(v)
   print(vim.inspect(v))
   return v
end
