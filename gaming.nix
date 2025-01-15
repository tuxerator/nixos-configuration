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
    ];
  };
}
