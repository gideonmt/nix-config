{ config, pkgs, ... }:

{
  imports = [
    ./modules/home/terminal.nix   # kitty + zsh
    ./modules/home/editor.nix     # neovim
    ./modules/home/files.nix      # lf + preview scripts
    ./modules/home/desktop.nix    # niri + waybar + fuzzel
    ./modules/home/music.nix      # ncspot + sptlrx
    ./modules/home/git.nix
    ./modules/home/packages.nix
  ];

  home.username    = "gideon";
  home.homeDirectory = "/home/gideon";
  home.stateVersion  = "25.11";

  programs.home-manager.enable = true;

  # XDG dirs
  xdg.enable = true;
  xdg.userDirs = {
    enable       = true;
    createDirectories = true;
  };
}
