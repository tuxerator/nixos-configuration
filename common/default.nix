{ config, lib, pkgs, ... }:

let
  inherit (import ./resources/lib.nix { inherit lib; }) frame;
  palette = import ./resources/palette.nix { inherit lib; };
in
{
  imports = [
    ./applications.nix
    ./desktop.nix
    ./gnupg.nix
    ./networking.nix
    ./nix.nix
    ./user.nix
    ./greetd.nix
    ./ssh.nix
    ./audio.nix
  ];

  nixpkgs.config.allowUnfree = true;
  nix.settings.trusted-users = [ "@wheel" "jakob" "root" ];

  # Use grub EFI boot loader.
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      devices = [ "nodev" ];
      efiSupport = true;
      enable = true;
      enableCryptodisk = true;
    };
  };
  boot.plymouth.enable = true;
  boot.initrd.preDeviceCommands = with palette.ansiFormat; ''
    info $'\n'${lib.escapeShellArg (frame magenta ''
    ${magenta "If found, please contact:"}

    ${cyan "Name:"} ${config.user.name}
    ${cyan "Email:"} ${config.user.email}
    ${cyan "Phone:"} ${config.user.phone}
    '')}$'\n'
  '';


  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];
  boot.extraModprobeConfig = ''
    options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
  '';
  security.polkit.enable = true;

  # Locale settings
  time.timeZone = "Europe/Berlin";
  i18n = {
    defaultLocale = "en_DK.UTF-8";
  };

  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  services = {
    xserver = {
      xkb = {
        layout = "us";
        variant = "altgr-intl";
      };
    };
    udisks2.enable = true;
  };

  fonts = {
    packages = with pkgs; [
      nerd-fonts.meslo-lg
      nerd-fonts.hack
    ];
    fontconfig.defaultFonts = {
      monospace = [ "Hack Nerd Font" ];
    };
  };
}
