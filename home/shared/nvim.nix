{ config, pkgs, lib, ... }:

{
  programs.neovim = {
    enable        = true;
    defaultEditor = true;
    viAlias       = true;
    vimAlias      = true;

    plugins = with pkgs.vimPlugins; [
      # LSP
      mason-nvim
      mason-lspconfig-nvim
      nvim-lspconfig

      # Completion
      nvim-cmp
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      cmp-cmdline

      # Treesitter
      nvim-treesitter.withAllGrammars
      nvim-treesitter-textobjects

      # Telescope
      telescope-nvim
      plenary-nvim

      # UI
      oxocarbon-nvim
      lualine-nvim
      nvim-web-devicons
      bufferline-nvim
      indent-blankline-nvim
      nvim-notify

      # Git
      gitsigns-nvim
      vim-fugitive

      # Editor
      nvim-surround
      nvim-colorizer-lua
      nvim-cursorline
      marks-nvim
      oil-nvim
      nvim-numbertoggle
      venn-nvim

      # LaTeX / Typst
      vimtex
      typst-vim
    ];

    extraPackages = with pkgs; [
      # LSP servers
      lua-language-server
      clang-tools
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
      pyright
      gopls
      texlab

      # Telescope
      ripgrep
      fd
    ];
  };

  # Link nvim lua config into ~/.config/nvim
  xdg.configFile."nvim" = {
    source    = ../nvim;
    recursive = true;
  };
}
