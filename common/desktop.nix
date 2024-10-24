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
    services.xserver = lib.mkIf cfg.awesome.enable {
      enable = true;
      windowManager.awesome.enable = true;
      displayManager.startx.enable = true;
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


    environment.sessionVariables = {
      NIXOS_OZONE_WL = "1";
      OGL_DEDICATED_HW_STATE_PER_CONTEXT = "ENABLE_ROBUST";
    };
  };
}
