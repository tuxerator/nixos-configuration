{ pkgs, lib, config, ... }:
let
  sway-config = pkgs.writeText "greetd-sway-config" ''
    exec "${pkgs.greetd.regreet}/bin/regreet; swaymsg exit"
    bindsym Mod4+shift+e exec swaynag \
      -t warning \
      -m 'What do you want to do?' \
      -b 'Poweroff' 'systemctl poweroff' \
      -b 'Reboot' 'systemctl reboot'
  '';
in
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.sway}/bin/sway --unsupported-gpu --config ${sway-config}";
      };
    };
  };
}
