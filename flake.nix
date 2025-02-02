{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hyprland.url = "github:hyprwm/Hyprland";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    musnix = { url = "github:musnix/musnix"; };

  };

  outputs = { self, nixpkgs, home-manager, sops-nix, musnix, ... }@inputs: {
    nixosConfigurations = {
      "carrie" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./carrie.nix
        ];
      };

      "carrie2" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          musnix.nixosModules.musnix
          sops-nix.nixosModules.sops
          ./carrie2.nix
        ];
      };
      "knime-thickPad" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./knime-thickPad.nix
        ];
      };
    };
  };
}
