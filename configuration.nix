# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual `nixos-help`).
{ config, lib, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Apple Keyboard en-US fix --- For ` to < and ~ to >
  boot.extraModprobeConfig = ''
    options hid_apple iso_layout=0
  '';

  networking.hostName = "macbook-nixos";

  # Configure network connections interactively with nmcli or nmtui.
  #networking.networkmanager.enable = true;
  # WiFi
  networking.wireless.iwd = {
    enable = true;
    settings.General.EnableNetworkConfiguration = true;
  };

  # Touchbar
  hardware.apple.touchBar = {
    enable = true;
    package = pkgs.tiny-dfr;
  };

  # Bluetooth
  hardware.bluetooth.enable = true;
  
  # Set your time zone.
  time.timeZone = "America/New_York";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

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
      serif = [ "Libertinus Serif" ];
      monospace  = [ "JetBrains Mono" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };

  # Enable Niri
  programs.niri.enable = true;
  
  # Apple Silicon audio
  hardware.asahi = {
    enable = true;
    setupAsahiSound = true;
    peripheralFirmwareDirectory = ./firmware;
  };

  # PipeWire audio stack
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

  # ly
  services.displayManager.ly = {
    enable = true;
    package = pkgs.ly;
  };

  # System packages (keep system-level tools here)
  environment.systemPackages = with pkgs; [
    neovim
    git
    zip
    unzip
    bluetui
  ];

  environment.pathsToLink = [ "/share" ];

  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  home-manager.backupFileExtension = "backup";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Define a user account. Don't forget to set a password with 'passwd'.
  users.users.gideon = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "sudo" ]; # Enable 'sudo' for the user.
  };

  # Enable the OpenSSH daemon.
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
