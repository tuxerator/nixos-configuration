{ config, pkgs, ... }:
{
  sops.secrets."ssh/yubikey_pub" = {
    owner = config.users.users.jakob.name;
  };

  services.openssh = {
    enable = true;
    settings = {
      UseDns = true;
      X11Forwarding = false;
      PermitRootLogin = "no";
    };
  };

  networking.firewall.allowedTCPPorts = [ 22 ];
  users.users.jakob.openssh.authorizedKeys.keys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCbkRPsI4NrFzsGlWFZDsMfs3alM8YWtXeUsORKz09Xhivq3+FJ1RQtSQhoxCD8XO8sewsifZoHn6mE0mIIsJB/zh6igxztW0IkuK8pRCnUSVaRspkD6u5tmQFav3zxQdfx1yWzRRQjaN3V+vIApwwacdMUQW8qU+I8s8D4XIwgnCMSr0amJ/Gtl6tm2aKVoQ/bblMoWe+wqVEpO6WDMn7u3zZArFQSuidDWBGGYRW+b14gSwtFSmSh/obzPWH2U14iIjfmQyU8uJKw+c5LTlQPDHkXoa1aH7D4QxqJRuIsa+oKnE4XubyxRxZoTlikqIbug2F2FJdc8gZO4oxqSE0V openpgp:0x0B90D3D2"
  ];
}
