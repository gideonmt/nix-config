{ config, pkgs, lib, ... }:

{
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "gideonmt";
        email = "gideonmarcustrask@gmail.com";
      };

      core.editor    = "nvim";
      init.defaultBranch = "main";
      pull.rebase    = false;
      push.autoSetupRemote = true;

      diff.colorMoved       = "zebra";
      merge.conflictstyle   = "diff3";
    };
  };
}
