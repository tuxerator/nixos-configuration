{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs: {
    nixosConfigurations = {
      "carrie" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./carrie.nix
        ];
      };

      "knime-thickPad" = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./knime-thickPad.nix
        ];
      };
    };
  };
}
