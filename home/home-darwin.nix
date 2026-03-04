{ config, pkgs, lib, ... }:

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
    ./darwin/wm.nix
    ./darwin/cli.nix
  ];

  home.username      = "gideonmarcus-trask";
  home.homeDirectory = lib.mkForce "/Users/gideonmarcus-trask";
  home.stateVersion  = "25.11";

  programs.home-manager.enable = true;

  xdg.enable = true;
  xdg.userDirs = {
    enable            = true;
    createDirectories = true;
  };
}
