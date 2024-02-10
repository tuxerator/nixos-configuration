{ config, lib, ... }:

let
  cfg = config;
in
{
  services.printing = {
    enable = true;
  };

  users.users.${cfg.user.username}.extraGroups = [ "lp" ];
}
