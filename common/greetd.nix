{ pkgs, config, ... }:
let

  sway-config = pkgs.writeText "sway-config" ''
    exec "${pkgs.greetd.regreet}/bin/regreet; ${pkgs.sway}/bin/swaymsg exit"
    bindsym Mod4+shift+e exec swaynag \
      -t warning \
      -m 'What do you want to do?' \
      -b 'Poweroff' 'systemctl poweroff' \
      -b 'Reboot' 'systemctl reboot'

    include /etc/sway/config.d/*
  '';
in
{
  programs.regreet = {
    enable = true;
    cageArgs = [
      "-s"
    ];
  };
}
