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

  services.flatpak.enable = true;

  environment.systemPackages = with pkgs; [
    git
    wget
    htop
    unzip
    nss
  ];
  environment.defaultPackages = [ ];
}
