{
  description = "NixOS configuration";

  inputs = {
    # Essentials
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # My Flakes
    cli.url = "github:xvrqt/cli-flake";
    #cli.url = "/home/amy/Development/cli-flake";
    #niri.url = "github:xvrqt/niri-flake";
    niri.url = "/home/amy/Development/niri-flake";
    packages.url = "./pkgs";

    # 3rd Party Flakes
    nvf.url = "github:notashelf/nvf";
  };

  outputs = inputs @ {
    cli,
    nvf,
    niri,
    nixpkgs,
    packages,
    home-manager,
    ...
  }: {
    nixosConfigurations = let
      machine = "nyaa";
    in {
      nyaa = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
        specialArgs = {
          inherit inputs;
        };
        modules = [
          niri.nixosModules.default
          # Main NixOS Module - Pulls in its own sub-modules
          ./nyaa.nix
          # Home Manager as a NixOS Module
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              extraSpecialArgs = {inherit packages;};
              # Use pkgs configured at the system level
              useGlobalPkgs = true;
              # Install packages to /etc/profiles
              useUserPackages = true;
              # List of Home Manager Modules
              users.amy = {...}: {
                imports = [
                  # Shell Customization & Useful Command Programs
                  cli.homeManagerModules.default
                  # Highly Customized NeoVim
                  nvf.homeManagerModules.default
                  niri.homeManagerModules.${machine}
                  packages.features.blender.homeManagerModules.default
                  # Main Home Manager Module
                  ./home.nix
                ];
              };
            };
            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
        ];
      };
    };
  };
}
