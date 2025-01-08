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

  };

  config = {
    services.libinput = {
      enable = true;
      mouse = {
        accelProfile = "flat";
      };
    };

    programs.hyprland = lib.mkIf cfg.hyprland.enable {
      enable = true;
      xwayland.enable = false;
    };

    programs.hyprlock.enable = lib.mkIf cfg.hyprland.enable true;


    xdg.portal.extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];

    environment.systemPackages = with pkgs; [
      wl-clipboard-rs
    ];


    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      OGL_DEDICATED_HW_STATE_PER_CONTEXT = "ENABLE_ROBUST";
    };
  };
}
