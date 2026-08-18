{
  description = "My NixOS-WSL configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    yazi-flavors = {
      url = "github:yazi-rs/flavors";
      flake = false;
    };

    eza-themes = {
      url = "github:eza-community/eza-themes";
      flake = false;
    };
  };

  outputs =
    inputs@{
      nixpkgs,
      nixpkgs-unstable,
      nixos-wsl,
      home-manager,
      ...
    }:
    let
      system = "x86_64-linux";
      username = "nixos";

      unstableOverlay = final: _prev: {
        unstable = import nixpkgs-unstable {
          system = final.stdenv.hostPlatform.system;

          config = {
            allowUnfree = true;
          };
        };
      };
    in
    {
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt-tree;
      nixosConfigurations.wsl = nixpkgs.lib.nixosSystem {
        inherit system;

        specialArgs = {
          inherit inputs username;
        };

        modules = [
          nixos-wsl.nixosModules.default
          home-manager.nixosModules.home-manager

          {
            nixpkgs.overlays = [
              unstableOverlay
            ];
          }

          ./configuration.nix
        ];
      };
    };
}
