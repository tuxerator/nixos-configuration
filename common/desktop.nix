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

    programs.hyprland = lib.mkIf cfg.hyprland.enable {
      enable = true;
      xwayland.enable = true;
    };
  };
}
