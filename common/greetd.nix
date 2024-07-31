{ pkgs, lib, config, ... }:
let

  sway-config = pkgs.writeText "sway-config" ''
    exec "${lib.getExe pkgs.greetd.regreet}; swaymsg exit"
    bindsym Mod4+shift+e exec swaynag \
      -t warning \
      -m 'What do you want to do?' \
      -b 'Poweroff' 'systemctl poweroff' \
      -b 'Reboot' 'systemctl reboot'

    include /etc/sway/config.d/*
  '';
in
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.dbus}/bin/dbus-run-session${pkgs.dbus}/bin/dbus-run-session  ${lib.getExe pkgs.sway} --config ${sway-config}";
      };
    };
  };
}
