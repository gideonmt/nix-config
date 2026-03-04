{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    ffmpegthumbnailer
    poppler-utils
    unar
    wl-screenrec
    wbg
    bluetui
  ];
}
