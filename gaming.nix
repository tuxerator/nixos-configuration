{ config, pkgs, ... }:

{
  programs.steam = {
    enable = true;
    extraPackages = with pkgs; [
      bash
      gawk
      git
      procps
      unixtools.xxd
      unzip
      wget
      xdotool
      xorg.xprop
      xorg.xrandr
      xorg.xwininfo
      yad
      gamescope
      winetricks
      zenity
      freetype
      binutils
      mono
      toybox
      vim
      winePackages.unstableFull
      wine64Packages.unstableFull
      wineWowPackages.unstableFull
      wineWow64Packages.unstableFull
    ];
  };

  environment.systemPackages = with pkgs; [
    winePackages.unstableFull
    wine64Packages.unstableFull
    wineWowPackages.unstableFull
    wineWow64Packages.unstableFull
  ];
}
