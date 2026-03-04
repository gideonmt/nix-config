local function get_visual(_, parent)
   if #parent.snippet.env.LS_SELECT_RAW > 0 then
      return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
   else
      return sn(nil, i(1, ""))
   end
end

local line_begin = require("luasnip.extras.expand_conditions").line_begin

-- Math context detection
local tex = {}
tex.in_mathzone = function()
   return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end
tex.in_text = function()
   return not tex.in_mathzone()
end

return {
   s(
      { trig = "([^%a])MM", wordTrig = false, regTrig = true },
      fmta("<>$<>$", {
         f(function(_, snip)
            return snip.captures[1]
         end),
         d(1, get_visual),
      })
   ),
}
