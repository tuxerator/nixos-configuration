{ config, lib, pkgs, ... }:

let
  cfg = config;
in
{
  services.printing = {
    enable = true;
  };
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };
  users.users.${cfg.user.username}.extraGroups = [ "lp" ];

  environment.systemPackages = [
    pkgs.cups
  ];

  hardware.printers = {
    ensurePrinters = [
      {
        name = "Pappiertigger";
        location = "PZ809";
        deviceUri = "ipp://papiertigger.fachschaft.inf.uni-konstanz.de";
        model = "drv:///sample.drv/generic.ppd";
        ppdOptions = {
          PageSize = "A4";
        };
      }
    ];
  };
}
