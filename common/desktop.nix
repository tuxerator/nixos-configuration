{ config, lib, pkgs, inputs, ... }:

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
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      enable = true;
      xwayland.enable = true;
    };

    nix.settings = {
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
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
