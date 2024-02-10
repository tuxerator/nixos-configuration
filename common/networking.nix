{ config, lib, ... }:

let
  cfg = config;
in
{
  options.host.name = lib.mkOption {
    type = lib.types.str;
  };

  config = {
    networking.hostName = cfg.host.name;
    networking.networkmanager.enable = true;


    # Permissions
    users.users.${cfg.user.username}.extraGroups = [ "networkmanager" ];
  };
}
