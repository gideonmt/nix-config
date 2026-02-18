{ config, pkgs, lib, ... }:

let
  c = import ./colors.nix;
in
{
  # Kitty
  programs.kitty = {
    enable = true;

    font = {
      name = "JetBrains Mono";
      size = 10;
    };

    settings = {
      # Tabs
      active_tab_font_style   = "bold";
      inactive_text_alpha     = "0.8";
      tab_bar_edge            = "bottom";
      tab_bar_style           = "powerline";
      tab_powerline_style     = "angled";
      tab_title_template      = "{index}";
      active_tab_title_template = "{index}";

      active_tab_foreground   = c.bg;
      active_tab_background   = c.pink;
      inactive_tab_foreground = c.fg;
      inactive_tab_background = c.bg-muted;
      tab_bar_background      = c.bg;

      # Window / cursor
      foreground              = c.fg;
      background              = c.bg;
      selection_foreground    = c.fg-bright;
      selection_background    = c.base03;

      cursor                  = c.fg-bright;
      cursor_text_color       = c.bg-muted;

      url_color               = c.pink;
      url_style               = "single";

      active_border_color     = c.pink;
      inactive_border_color   = c.magenta;
      bell_border_color       = c.pink;

      macos_titlebar_color    = c.bg;

      # 16-color palette
      color0  = c.bg-subtle;
      color8  = c.bg-muted;
      color1  = c.magenta;
      color9  = c.magenta;
      color2  = c.green;
      color10 = c.green;
      color3  = c.lavender;
      color11 = c.lavender;
      color4  = c.blue;
      color12 = c.blue;
      color5  = c.pink;
      color13 = c.pink;
      color6  = c.cyan;
      color14 = c.cyan;
      color7  = c.fg;
      color15 = c.fg-bright;

      # Remote control
      allow_remote_control = "yes";
    };

    keybindings = {
      "shift+cmd+l" = "next_tab";
      "shift+cmd+h" = "previous_tab";
    };
  };

  programs.zsh = {
    enable = true;

    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
      {
        name = "powerlevel10k-config";
        src = ./assets;
        file = "p10k.zsh";
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.zsh-syntax-highlighting;
        file = "share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh";
      }
    ];

    initContent = ''
      lf() {
        export LF_CD_FILE="/var/tmp/.lfcd-$$"
        command lf "$@"
        if [ -s "$LF_CD_FILE" ]; then
          local DIR="$(realpath -- "$(cat -- "$LF_CD_FILE")")"
          if [[ "$DIR" != "$PWD" ]]; then
            cd "$DIR"
          fi
          rm "$LF_CD_FILE"
        fi
        unset LF_CD_FILE
      }
    '';

    shellAliases = {
      ls    = "ls --color=auto";
      ll    = "ls -lh --color=auto";
      la    = "ls -lah --color=auto";
      ".."  = "cd ..";
      "..." = "cd ../..";
      update = "sudo nixos-rebuild switch --flake /etc/nixos#macbook-nixos";
      edit   = "sudo -e";
      v      = "nvim";
    };

    history = {
      size        = 10000;
      save        = 10000;
      path        = "$HOME/.zsh_history";
      ignoreDups  = true;
      ignoreSpace = true;
      share       = true;
    };

    dotDir = "${config.xdg.configHome}/zsh";
  };
}
