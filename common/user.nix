{ config, lib, pkgs, ... }:

let
  cfg = config;
  inherit (lib) mkOption;
in
{
  options = {
    user = {
      name = mkOption { type = lib.types.str; };
      username = mkOption { type = lib.types.str; };
      email = mkOption { type = lib.types.str; };
      phone = mkOption { type = lib.types.str; };
      shell = mkOption { default = pkgs.zsh; type = lib.types.package; };
    };
  };

  config = {
    users.mutableUsers = true;
    users.groups.${cfg.user.username}.gid = 1000;
    users.users.${cfg.user.username} = {
      uid = 1000;
      isNormalUser = true;
      extraGroups = [ "wheel" "adbusers" "audio" "jackaudio" ];
      description = cfg.user.name;
      shell = cfg.user.shell;
    };
  };
}
