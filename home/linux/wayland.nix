{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    wl-clipboard
    cliphist
    bemoji
    wlr-which-key
    xwayland-satellite
  ];
}
