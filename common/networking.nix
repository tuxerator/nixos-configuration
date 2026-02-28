{ config, lib, pkgs, ... }:

let cfg = config;
in {
  options.host.name = lib.mkOption { type = lib.types.str; };

  config = {
    networking.hostName = cfg.host.name;
    networking.networkmanager.enable = true;

    services.avahi = {
      enable = true;
      nssmdns4 = true;
      nssmdns6 = true;
      publish.addresses = true;
    };

    environment.systemPackages = with pkgs; [ networkmanager-openvpn ];

    networking.firewall.allowedTCPPortRanges = [
      # KDEConnect
      {
        from = 1714;
        to = 1764;
      }
    ];
    networking.firewall.allowedUDPPortRanges = [
      # KDEConnect
      {
        from = 1714;
        to = 1764;
      }
    ];

    # Permissions
    users.users.${cfg.user.username}.extraGroups = [ "networkmanager" ];
  };
}
