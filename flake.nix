{
  description = "NixOS configuration";

  inputs = {
    # Essentials
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Window Manager
    niri.url = "github:xvrqt/niri-flake";
    # TTY Emulator, CLI Programs, Fonts
    terminal.url = "github:xvrqt/terminal-flake";
    # Rust Programming Language Toolchain
    rust.url = "/home/amy/Development/rust-flake";
    # Blender 3D Rendering Program
    #blender.url = "/home/amy/Development/blender-flake";
  };

  outputs = inputs @ {
    rust,
    niri,
    nixpkgs,
    # blender,
    terminal,
    home-manager,
    ...
  }: {
    nixosConfigurations = let
      system = "x86_64-linux";
      machine = "nyaa";
      overlays = [];
    in {
      nyaa = nixpkgs.lib.nixosSystem {
        pkgs = import nixpkgs {
          inherit system overlays;
          config.allowUnfree = true;
        };
        specialArgs = {
          inherit inputs;
        };
        modules = [
          # Window manager
          niri.nixosModules.default
          # Rust Programming Language Toolchain
          rust.nixosModules.default
          # Blender Program
          # blender.nixosModules.default
          # Main NixOS Module - Pulls in its own sub-modules
          ./nyaa.nix

          # Home Manager as a NixOS Module
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              # Use pkgs configured at the system level
              useGlobalPkgs = true;
              # Install packages to /etc/profiles
              useUserPackages = true;
              # List of Home Manager Modules
              users.amy = {...}: {
                imports = [
                  # Window Manager (for some reason needs HM to customize)
                  niri.homeManagerModules.${machine}
                  # TTY Emulator, CLI Programs, Fonts
                  terminal.homeManagerModules.${system}.default
                  # Main Home Manager Module
                  ./home.nix
                ];
              };
            };
          }
        ];
      };
    };
  };
}
