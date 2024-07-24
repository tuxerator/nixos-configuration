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

    services.avahi = {
      enable = true;
      nssmdns4 = true;
      nssmdns6 = true;
      publish.addresses = true;
    };


    # Permissions
    users.users.${cfg.user.username}.extraGroups = [ "networkmanager" ];
  };
}
