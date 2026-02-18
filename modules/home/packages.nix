{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    # Shell utilities
    bat
    eza
    fd
    ripgrep
    fzf
    jq
    glow
    mediainfo
    ffmpegthumbnailer
    poppler-utils
    pandoc
    unar
    cliphist
    wl-clipboard
    bemoji
    
    btop

    wlr-which-key
    
    wl-screenrec

    wbg # wall paper 

    # Dev tools
    gcc
    go
    python3
    nodejs

    # Desktop / UI
    vesktop
    firefox
    brightnessctl
    playerctl
    wireplumber

    # Fonts
    nerd-fonts.jetbrains-mono
  ];
}
