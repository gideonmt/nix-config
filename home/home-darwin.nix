{ config, pkgs, ... }:

{
  imports = [
    ./shared/shell.nix
    ./shared/kitty.nix
    ./shared/nvim.nix
    ./shared/lf.nix
    ./shared/git.nix
    ./shared/music.nix
    ./shared/cli.nix
    ./shared/browser.nix
    ./shared/discord.nix
  ];

  home.username      = "gideon";
  home.homeDirectory = "/Users/gideon";
  home.stateVersion  = "25.11";

  programs.home-manager.enable = true;

  xdg.enable = true;
  xdg.userDirs = {
    enable            = true;
    createDirectories = true;
  };
}
