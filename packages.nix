{ config, pkgs, ... }:

{
  nixpkgs.config = {
    allowUnfree = true;
  };

  environment.systemPackages = with pkgs; [
    git
    wget
    htop
    unzip
  ];
  environment.defaultPackages = [ ];
}
