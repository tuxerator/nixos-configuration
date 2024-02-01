{ config, pkgs, ... }:

{
  # services.greetd = {
  #   enable = true;
  #   restart = true;
  # };

  # programs.regreet.enable = true;

  programs.hyprland = {
    enable = true;  
    xwayland.enable = true;
  };

  services.xserver = {
    windowManager.awesome.enable = true;
    displayManager.gdm.enable = true;
    deviceSection = ''
      Option "VariableRefresh" "true"
    '';
  };
}
