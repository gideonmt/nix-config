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
    bluetui

    wlr-which-key
    
    wl-screenrec

    wbg # wall paper 

    # Dev tools
    python3
    nodejs

    # Desktop / UI
    vesktop
    firefox

    # Fonts
    nerd-fonts.jetbrains-mono
  ];
}
