{ config, pkgs, ... }:
let cfg = config;
in
{
  musnix = {
    enable = true;
    soundcardPciId = "2d:00.4";
  };

  boot.kernelParams = [ "PREEMT_RT=FULL" ];

  services.pipewire = {
    jack.enable = true;
    extraConfig.pipewire = {
      "10-clock-rates" = {
        "context.properties" = {
          "default.clock.allowed-rates" = [ 44100 48000 ];
        };
      };

      "92-low-latency" = {
        "context.properties" = {
          "default.clock.rate" = 48000;
          "default.clock.quantum" = 128;
          "default.clock.min-quantum" = 64;
          "default.clock.max-quantum" = 256;
        };

      };
    };
  };

  environment.systemPackages = with pkgs; [
    qpwgraph
  ];
}
