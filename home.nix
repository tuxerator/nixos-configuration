{ config, pkgs, ... }:

{
  home.username = "jakob";
  home.homeDirectory = "/home/jakob";
  home.stateVersion = "24.05";
  programs.home-manager.enable = true;
}
