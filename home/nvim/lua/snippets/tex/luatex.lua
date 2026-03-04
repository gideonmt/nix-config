local function get_visual(_, parent)
   if #parent.snippet.env.LS_SELECT_RAW > 0 then
      return sn(nil, i(1, parent.snippet.env.LS_SELECT_RAW))
   else
      return sn(nil, i(1, ""))
   end
end

-- Return snippet tables
return {
   -- tex.sprint
   s(
      { trig = "tpp", snippetType = "autosnippet" },
      fmta(
         [[
        tex.sprint(<>)
      ]],
         {
            d(1, get_visual),
         }
      )
   ),
}
