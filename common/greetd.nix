{ pkgs, lib, config, ... }:

{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.greetd}/bin/agreety --cmd Hyprland";
        user = "greeter";
      };
    };
  };

  services.displayManager.enable = true;
}
