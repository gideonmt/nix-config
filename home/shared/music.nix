{ config, lib, pkgs, ... }:

{
  home.packages = [ pkgs.sptlrx ];

  programs.ncspot = {
    enable = true;
    settings = {
      shuffle = false;
      gapless = true;
      notify = true;
      media_control = true;
    };
  };

  xdg.configFile."sptlrx/config.yaml".text = lib.generators.toYAML {} {
    player = "mpris";
    ignoreErrors = true;
    timerInterval = 200;
    updateInterval = 2000;

    mpris = {
      players = [ "ncspot" ];
    };

    style = {
      hAlignment = "center";
      before = {
        bold = true;
        italic = false;
        faint = false;
      };
      current = {
        bold = true;
        italic = false;
        faint = false;
      };
      after = {
        bold = false;
        italic = false;
        faint = true;
      };
    };
  };
}
