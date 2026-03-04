{ config, lib, pkgs, ... }:

{
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
      update() {
        if [[ "$(uname)" == "Darwin" ]]; then
          darwin-rebuild switch --flake /etc/nixos#$(scutil --get LocalHostName) --impure
        else
          sudo nixos-rebuild switch --flake /etc/nixos#$(hostname) --impure
        fi
      }


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
