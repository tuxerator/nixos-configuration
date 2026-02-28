{ config, pkgs, ... }:

{
  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };
  programs.steam = {
    enable = true;
    extraPackages = with pkgs; [
      bash
      gawk
      git
      gtk2-x11
      gtk2
      procps
      unixtools.xxd
      unzip
      wget
      xdotool
      xorg.xprop
      xorg.xrandr
      xorg.xwininfo
    ];
  };
}
