{ config, pkgs, ... }:
let cfg = config;
in
{
  musnix = {
    enable = false;
    alsaSeq.enable = true;
  };
}
