{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    bat
    eza
    fd
    ripgrep
    fzf
    jq
    glow
    mediainfo
    pandoc
    tree
    btop
    (python3.withPackages (ps: [
      ps.tkinter
      ps.numpy
      ps.requests
    ]))
    nodejs
    nerd-fonts.jetbrains-mono
  ];
}
