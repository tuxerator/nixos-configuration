{ config, lib, pkgs, ... }:

let
  cfg = config;
in
{
  options = {
    hyprland.enable = lib.mkOption {
      default = true;
      defaultText = "Enable Hyprland";
      example = false;
      type = lib.types.bool;
    };

    awesome.enable = lib.mkEnableOption "awesome";
  };

  config = {
    services.xserver = lib.mkIf (cfg.hyprland.enable || cfg.awesome.enable) {
      enable = true;
      displayManager.gdm = {
        enable = true;
      };
      windowManager.awesome.enable = cfg.awesome.enable;
    };

    services.libinput = {
      enable = true;
      mouse = {
        accelProfile = "flat";
      };
    };

    programs.hyprland = lib.mkIf cfg.hyprland.enable {
      enable = true;
      xwayland.enable = true;
    };

    programs.hyprlock.enable = lib.mkIf cfg.hyprland.enable true;

    programs.kdeconnect.enable = true;

    xdg.portal.extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];

    environment.systemPackages = with pkgs; [
      wl-clipboard-rs
    ];
  };
}
