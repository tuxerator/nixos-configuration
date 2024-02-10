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
  ];

  nixpkgs.config.allowUnfree = true;

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
  };

  fonts = {
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "Meslo" "Hack" ]; })
    ];
    fontconfig.defaultFonts = {
      monospace = [ "Hack Nerd Font" ];
    };
  };
}
