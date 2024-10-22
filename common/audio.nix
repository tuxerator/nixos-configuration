{ config, pkgs, ... }:
let cfg = config;
in
{
  security.pam.loginLimits = [
    { domain = "@audio"; item = "memlock"; type = "-"; value = "unlimited"; }
    { domain = "@audio"; item = "rtprio"; type = "-"; value = "99"; }
  ];

  services.pipewire.jack.enable = true;
}
