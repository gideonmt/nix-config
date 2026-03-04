require("nvim-treesitter").setup({
   auto_install = true,
   ensure_installed = {
      "c", "cpp", "rust", "go", "d",
      "java", "kotlin", "scala",
      "haskell", "ocaml", "erlang", "elixir",
      "python", "lua", "ruby", "javascript", "typescript", "tsx",
      "commonlisp", "scheme", "clojure",
      "c_sharp",
      "html", "css",
      "json", "yaml", "toml",
      "markdown", "markdown_inline", "vim", "vimdoc",
      "bash",
   },
   highlight = { 
      enable = true,
   },
   indent = { enable = true },
   incremental_selection = {
      enable = true,
      keymaps = {
         init_selection = "<CR>",
         node_incremental = "<CR>",
         scope_incremental = "<S-CR>",
         node_decremental = "<BS>",
      },
   },
   textobjects = {
      select = {
         enable = true,
         lookahead = true,
         keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
         },
      },
      move = {
         enable = true,
         set_jumps = true,
         goto_next_start = {
            ["]f"] = "@function.outer",
            ["]c"] = "@class.outer",
         },
         goto_next_end = {
            ["]F"] = "@function.outer",
            ["]C"] = "@class.outer",
         },
         goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[c"] = "@class.outer",
         },
         goto_previous_end = {
            ["[F"] = "@function.outer",
            ["[C"] = "@class.outer",
         },
      },
   },
})
