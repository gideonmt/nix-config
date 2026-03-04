{ config, lib, pkgs, ... }:

{
  networking.hostName = "gideon-mac";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    neovim
    git
    zip
    unzip
  ];

  fonts.packages = with pkgs; [
    jetbrains-mono
    libertinus
    noto-fonts-color-emoji
    ibm-plex
    nerd-fonts.jetbrains-mono
  ];

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  system.stateVersion = 6;
}
