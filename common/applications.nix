{ config, lib, pkgs, ... }:

{
  programs = {
    git = {
      enable = true;
    };

    zsh = {
      enable = true;
    };

    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        bash
        nss
      ];
    };
  };

  programs.adb.enable = true;

  services.flatpak.enable = true;
  services.ratbagd.enable = true;

  environment.systemPackages = with pkgs; [
    git
    wget
    htop
    unzip
    nss
    sops
    cachix
  ];
  environment.defaultPackages = [ ];
}
