{
    description = "Mz's Flake";

    inputs = {
        nixpkgs.url = "nixpkgs/nixos-unstable";
        home-manager.url = "github:nix-community/home-manager/master";
        home-manager.inputs.nixpkgs.follows = "nixpkgs";

        nixpkgs-stable.url = "nixpkgs/nixos-24.05";
        home-manager-stable.url = "github:nix-community/home-manager/release-24.05";
        home-manager-stable.inputs.nixpkgs.follows = "nixpkgs-stable";

        nix-on-droid.url = "github:nix-community/nix-on-droid/master";
        nix-on-droid.inputs.nixpkgs.follows = "nixpkgs";
        nix-on-droid.inputs.home-manager.follows = "home-manager";
    };

    outputs = { self, nixpkgs, home-manager, nix-on-droid, ... } @ inputs:
    let
        lib = nixpkgs.lib;
        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
    in {
        nixosConfigurations = {
            Mz = lib.nixosSystem {
                inherit system;
                specialArgs = { inherit inputs; };
                modules = [
                    ./profiles/system/Mz.nix
                    inputs.home-manager.nixosModules.default
                ];
            };
        };

        nixOnDroidConfigurations = {
            MzBrick = inputs.nix-on-droid.lib.nixOnDroidConfiguration {
                pkgs = import nixpkgs {system = "aarch64-linux";};
                modules = [./profiles/system/MzBrick.nix];
            };
        };

        homeConfigurations = {
            mz = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                extraSpecialArgs = {inherit inputs;};
                modules = [./profiles/user/mz.nix];
            };

            server = home-manager.lib.homeManagerConfiguration {
                inherit pkgs;
                extraSpecialArgs = {inherit inputs;};
                modules = [./profiles/user/server.nix];
            };
        };
    };
}
