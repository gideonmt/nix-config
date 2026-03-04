{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.extraModprobeConfig = ''
    options hid_apple iso_layout=0
  '';

  networking.hostName = "macbook-nixos";

  networking.wireless.iwd = {
    enable = true;
    settings.General.EnableNetworkConfiguration = true;
  };

  hardware.apple.touchBar = {
    enable = true;
    package = pkgs.tiny-dfr;
  };

  hardware.bluetooth.enable = true;

  time.timeZone = "America/New_York";

  fonts.packages = with pkgs; [
    jetbrains-mono
    libertinus
    noto-fonts-color-emoji
    ibm-plex
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      sansSerif  = [ "IBM Plex Sans" ];
      serif      = [ "Libertinus Serif" ];
      monospace  = [ "JetBrains Mono" ];
      emoji      = [ "Noto Color Emoji" ];
    };
  };

  programs.niri.enable = true;

  hardware.asahi = {
    enable = true;
    setupAsahiSound = true;
    peripheralFirmwareDirectory = /etc/nixos/firmware;
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    configPackages = [ pkgs.asahi-audio ];
    wireplumber = {
      enable = true;
      configPackages = [ pkgs.asahi-audio ];
    };
  };

  services.displayManager.ly = {
    enable = true;
    package = pkgs.ly;
  };

  environment.systemPackages = with pkgs; [
    neovim
    git
    zip
    unzip
    brightnessctl
    playerctl
  ];

  environment.pathsToLink = [ "/share" ];

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  services.printing.enable = true;

  users.users.gideon = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "sudo" ];
  };

  services.openssh = {
    enable = false;
    ports = [ 5432 ];
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
      AllowUsers = [ "" ];
    };
  };

  system.stateVersion = "25.11";
}
