{ config, pkgs, ... }:
{
  services.openssh = {
    enable = true;
    settings = {
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };

  networking.firewall.allowedTCPPorts = [ 22 ];
}
