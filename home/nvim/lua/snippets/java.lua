local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt

-- Filename → class name
local function filename(_, snip)
   local name = vim.fn.expand("%:t:r")
   return name:gsub("^%l", string.upper)
end

-- Expand only if file is empty
local function buffer_empty()
   return vim.api.nvim_buf_line_count(0) == 1
      and vim.api.nvim_buf_get_lines(0, 0, -1, false)[1] == ""
end

return {
   -- print
   s(
      { trig = ";pln", snippetType = "autosnippet" },
      fmt("System.out.println({});", { i(1) })
   ),

   -- main method
   s(
      { trig = ";mm", snippetType = "autosnippet" },
      fmt(
         [[
         public static void main(String[] args) {{
             {}
         }}
      ]],
         { i(1) }
      )
   ),

   -- class (only on empty buffer)
   s(
      { trig = ";cl", snippetType = "autosnippet" },
      fmt(
         [[
         public class {} {{
             public static void main(String[] args) {{
                 {}
             }}
         }}
      ]],
         { f(filename, {}), i(1) }
      ),
      { condition = buffer_empty }
   ),

   -- for loop (indexed)
   s(
      { trig = ";fil", snippetType = "autosnippet" },
      fmt(
         [[
         for (int {} = 0; {} < {}; {}++) {{
             {}
         }}
      ]],
         { i(1, "i"), rep(1), i(2, "n"), rep(1), i(3) }
      )
   ),

   -- for-each loop
   s(
      { trig = ";fel", snippetType = "autosnippet" },
      fmt(
         [[
         for ({} {} : {}) {{
             {}
         }}
      ]],
         { i(1, "Type"), i(2, "item"), i(3, "collection"), i(4) }
      )
   ),

   -- while loop
   s(
      { trig = ";wl", snippetType = "autosnippet" },
      fmt(
         [[
         while ({}) {{
             {}
         }}
      ]],
         { i(1), i(2) }
      )
   ),

   -- if-else
   s(
      { trig = ";ie", snippetType = "autosnippet" },
      fmt(
         [[
         if ({}) {{
             {}
         }} else {{
             {}
         }}
      ]],
         { i(1), i(2), i(3) }
      )
   ),

   -- try-catch
   s(
      { trig = ";tc", snippetType = "autosnippet" },
      fmt(
         [[
         try {{
             {}
         }} catch ({} {}) {{
             {}
         }}
      ]],
         { i(1), i(2, "Exception"), i(3, "e"), i(4) }
      )
   ),

   -- method definition
   s(
      { trig = ";md", snippetType = "autosnippet" },
      fmt(
         [[
         public {} {}({}) {{
             {}
         }}
      ]],
         { i(1, "void"), i(2, "methodName"), i(3), i(4) }
      )
   ),

   -- constructor
   s(
      { trig = ";ct", snippetType = "autosnippet" },
      fmt(
         [[
         public {}({}) {{
             {}
         }}
      ]],
         { f(filename, {}), i(1), i(2) }
      )
   ),
}
