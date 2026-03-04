{ config, lib, pkgs, ... }:

{
  networking.hostName = "gideon-mac";
  system.primaryUser = "gideonmarcus-trask";
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

  services.yabai = {
    enable = true;
    package = pkgs.yabai;
  };

  services.skhd = {
    enable = true;
    package = pkgs.skhd;
  };

  system.stateVersion = 6;
}
