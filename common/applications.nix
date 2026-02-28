{
  config,
  lib,
  pkgs,
  ...
}:

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
  programs.ausweisapp = {
    enable = true;
    openFirewall = true;
  };

  services.flatpak.enable = true;
  services.gnome.gnome-keyring.enable = true;

  environment.systemPackages = with pkgs; [
    git
    wget
    htop
    unzip
    nss
    sops
    cachix
    libsecret
    config.boot.kernelPackages.perf
    kdePackages.partitionmanager
    nvtopPackages.nvidia
  ];
  environment.defaultPackages = [ ];
}
