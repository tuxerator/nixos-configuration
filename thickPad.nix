# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [
      # Include the results of the hardware scan.
      ./thickPad-hardware-configuration.nix
      ./common
      ./secrets
    ];


  # System user
  user = {
    name = "Jakob Sanowski";
    username = "jakob";
    email = "jakob.sanowski@sanbach.de";
    phone = "+49 1523 1875485";
  };

  host.name = "thickPad";

  hyprland.enable = true;

  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    package = pkgs.nixFlakes;
  };

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };


  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-ocl
      intel-compute-runtime
      intel-media-driver
    ];
  };

  hardware.bluetooth.enable = true;

  # programs.light = {
  #   enable = true;
  #   brightnessKeys.enable = true;
  # };

  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
  ];

  services.auto-cpufreq = {
    enable = true;
    settings = {
      battery = {
        governor = "powersave";
        turbo = "never";
      };
      charger = {
        governor = "performance";
        turbo = "auto";
      };
    };
  };

  services.logind = {
    lidSwitch = "suspend-then-hibernate";
  };

  boot = {
    resumeDevice = "/dev/disk/by-uuid/776407ff-ca72-4d3d-8a04-314411e2b694";
    kernelParams = [
      "resume_offset=10347575"
    ];
  };

  systemd.sleep.extraConfig = "HibernateDelaySec=1h";

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?

}
