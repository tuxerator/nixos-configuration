# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./knime-thickPad-hardware-configuration.nix
      ./common
    ];

  # Disk encryption
  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-uuid/ad30225c-81bd-4311-aa1b-c8d04d880bf3";
      preLVM = true;
    };
  };


  environment.sessionVariables = { };

  hyprland.enable = true;

  # System user
  user = {
    name = "Jakob Sanowski";
    username = "jakob";
    email = "jakob.sanowski@knime.com";
    phone = "+49 1523 1875485";
  };

  host.name = "knime-thickPad";

  programs.java.enable = true;
  programs.java.package = pkgs.openjdk17-bootstrap;
  programs.steam.package = pkgs.steam.override { extraPkgs = pkgs: with pkgs; [ openjdk17-bootstrap ]; };
  programs.steam.enable = true;



  # Enable sound.
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.finegrained = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    prime = {
      reverseSync.enable = true;
      offload = {
        enableOffloadCmd = true;
      };
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:60:0:0";
    };
  };

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "23.11"; # Did you read the comment?

}

