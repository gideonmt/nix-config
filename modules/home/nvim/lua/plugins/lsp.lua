require("mason").setup({
   ui = {
      border = "rounded",
      icons = {
         package_installed = "✓",
         package_pending = "➜",
         package_uninstalled = "✗"
      }
   }
})

require("mason-lspconfig").setup({
   ensure_installed = {
      "lua_ls",
      "html",
      "cssls",
      "ts_ls",
      "eslint",
      "pyright",
      "gopls",
      "texlab",
   },
   automatic_installation = true,
})

vim.diagnostic.config({
   float = {
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
   },
   virtual_text = {
      prefix = "●",
      spacing = 4,
   },
   signs = {
      text = {
         [vim.diagnostic.severity.ERROR] = "",
         [vim.diagnostic.severity.WARN] = "",
         [vim.diagnostic.severity.HINT] = "",
         [vim.diagnostic.severity.INFO] = "",
      },
   },
   underline = true,
   update_in_insert = false,
   severity_sort = true,
})

local border = {
   { "╭", "FloatBorder" },
   { "─", "FloatBorder" },
   { "╮", "FloatBorder" },
   { "│", "FloatBorder" },
   { "╯", "FloatBorder" },
   { "─", "FloatBorder" },
   { "╰", "FloatBorder" },
   { "│", "FloatBorder" },
}

local handlers = {
   ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
   ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
}

local on_attach = function(client, bufnr)
   local opts = { buffer = bufnr, noremap = true, silent = true }

   vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
   vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
   vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
   vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
   vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
   vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
   vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
   vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, opts)
   vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, opts)
   vim.keymap.set("n", "<Leader>f", function()
      vim.lsp.buf.format({ async = true })
   end, opts)

   if client.server_capabilities.documentHighlightProvider then
      local group = vim.api.nvim_create_augroup("LSPDocumentHighlight", { clear = false })
      vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
         group = group,
         buffer = bufnr,
         callback = vim.lsp.buf.document_highlight,
      })
      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
         group = group,
         buffer = bufnr,
         callback = vim.lsp.buf.clear_references,
      })
   end
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

local servers = {
   lua_ls = {
      settings = {
         Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = {
               checkThirdParty = false,
               library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = { enable = false },
         },
      },
   },
   clangd = {
      cmd = {
         "clangd",
         "--background-index",
         "--clang-tidy",
         "--header-insertion=iwyu",
         "--completion-style=detailed",
         "--function-arg-placeholders",
      },
   },
   html = {},
   cssls = {},
   ts_ls = {},
   eslint = {},
   pyright = {
      settings = {
         python = {
            analysis = {
               typeCheckingMode = "basic",
               autoSearchPaths = true,
               useLibraryCodeForTypes = true,
            },
         },
      },
   },
   gopls = {
      settings = {
         gopls = {
            analyses = {
               unusedparams = true,
            },
            staticcheck = true,
         },
      },
   },
   texlab = {},
}

for server, config in pairs(servers) do
   config.capabilities = capabilities
   config.handlers = handlers
   vim.lsp.config(server, config)
end

vim.lsp.enable(vim.tbl_keys(servers))

vim.api.nvim_create_autocmd("LspAttach", {
   callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client then
         on_attach(client, args.buf)
      end
   end,
})
