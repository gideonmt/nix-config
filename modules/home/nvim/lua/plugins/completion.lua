local cmp = require("cmp")

local icon_map = {
   Text = "󰉿",
   Method = "󰆧",
   Function = "󰊕",
   Constructor = "",
   Field = "󰜢",
   Variable = "󰀫",
   Class = "󰠱",
   Interface = "",
   Module = "",
   Property = "󰜢",
   Unit = "󰑭",
   Value = "󰎠",
   Enum = "",
   Keyword = "󰌋",
   Snippet = "",
   Color = "󰏘",
   File = "󰈙",
   Reference = "󰈇",
   Folder = "󰉋",
   EnumMember = "",
   Constant = "󰏿",
   Struct = "󰙅",
   Event = "",
   Operator = "󰆕",
   TypeParameter = "",
}

cmp.setup({
   window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
   },
   mapping = cmp.mapping.preset.insert({
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }),
      ["<Tab>"] = cmp.mapping(function(fallback)
         if cmp.visible() then
            cmp.select_next_item()
         else
            fallback()
         end
      end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
         if cmp.visible() then
            cmp.select_prev_item()
         else
            fallback()
         end
      end, { "i", "s" }),
   }),
   sources = {
      { name = "nvim_lsp" },
      { name = "buffer" },
      { name = "path" },
   },
   formatting = {
      format = function(entry, item)
         item.kind = string.format('%s %s', icon_map[item.kind] or "", item.kind)
         item.menu = ({
            nvim_lsp = "[LSP]",
            buffer = "[Buffer]",
            path = "[Path]",
         })[entry.source.name]
         return item
      end
   },
})

cmp.setup.cmdline({ "/", "?" }, {
   mapping = cmp.mapping.preset.cmdline(),
   sources = { { name = "buffer" } },
})

cmp.setup.cmdline(":", {
   mapping = cmp.mapping.preset.cmdline(),
   sources = {
      { name = "path" },
      { name = "cmdline" },
   },
})
