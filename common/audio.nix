{ config, pkgs, ... }:
let cfg = config;
in {
  musnix = {
    enable = true;
    soundcardPciId = "2d:00.4";
    rtirq = {
      # highList = "snd_hrtimer";
      resetAll = 1;
      prioLow = 0;
      enable = true;
      nameList = "rtc0 snd";
    };
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
          "default.clock.quantum" = 256;
          "default.clock.min-quantum" = 64;
          "default.clock.max-quantum" = 256;
        };

      };
    };
    configPackages = [
      (pkgs.writeTextDir
        "share/pipewire/pipewire.conf.d/99-deepfilternet.conf" ''
          context.modules = [
              { name = libpipewire-module-filter-chain
                  args = {
                      node.description = "DeepFilter Noise Canceling Source"
                      media.name       = "DeepFilter Noise Canceling Source"
                      filter.graph = {
                          nodes = [
                              {
                                  type   = ladspa
                                  name   = "DeepFilter Mono"
                                  plugin = ${pkgs.deepfilternet}/lib/ladspa/libdeep_filter_ladspa.so
                                  label  = deep_filter_mono
                                  control = {
                                      "Attenuation Limit (dB)" 100
                                      "Min processing threshold (dB)" -10.0
                                      "Max ERB processing threshold (dB)" 30.0
                                      "Max DF processing threshold (dB)" 20.0
                                      "Min Processing Buffer (frames)" 0
                                      "Post Filter Beta" 0.02
                                  }
                              }
                          ]
                      }
                      audio.rate = 48000
                      audio.position = [MONO]
                      capture.props = {
                          node.passive = true
                      }
                      playback.props = {
                          media.class = Audio/Source
                      }
                  }
              }
          ]
        '')
    ];
  };

  environment.systemPackages = with pkgs; [ qpwgraph lilv coppwr ];
}
