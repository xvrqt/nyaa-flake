{
  description = "My main desktop.";

  inputs = {
    # Live Deliciously
    nixpkgs.url = "github:NixOs/nixpkgs/nixpkgs-unstable";
    # Home Manager (using it as a module)
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # # AI Art Generator
    # invokeai.url = "github:nixified-ai/flake";
    # # Desktop Environment
    # niri.url = "/home/amy/Development/niri-flake";
    # packages.url = "./pkgs";
  };

  outputs = {
    # nvf,
    # cli,
    # niri,
    nixpkgs,
    # packages,
    home-manager,
    ...
  } @ inputs: let
    # machine = "nyaa";
    # system = "x86_64-linux";
    # pkgs = import nixpkgs {
    #   inherit system;
    #   # Allow the installation of non-free packages (like Nvidia drivers)
    #   config.allowUnfree = true;
    # };
  in {
    nixosConfigurations.nyaa = nixpkgs.lib.nixosSystem {
      # Use the correct packages for the system
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        system = "x86_64-linux";
        # Allow the installation of non-free packages (like Nvidia drivers)
        config.allowUnfree = true;
      };
      # Pass the flake inputs to the NixOS Modules
      specialArgs = {
        inherit inputs;
      };
      # The Show
      modules = [
        # # Desktop Environment
        # niri.homeManagerModules.nyaa
        # # NeoVim
        # nvf.homeManagerModules.default
        # # Installs useful shell scripts
        # packages.scripts.home-manager-module
        # # # LLM AI
        # packages.features.llm.home-manager-module
        # # # Installs pretty fonts
        # packages.features.fonts.home-manager-module
        # # # 3D Modeling Software
        # packages.features.blender.home-manager-module
        # # # Terminal Emulator
        # packages.features.alacritty.home-manager-module
        # # # Web Browser focused on privacy
        # packages.features.librewolf.home-manager-module
        # # Adds in useful CLI tools, alias, and configurations
        # cli.homeManagerModules.default
        # Main NixOS Module (imports its own sub-modules)
        ./nyaa.nix
        # # Home Manager
        home-manager.nixosModule.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.amy = import ./home.nix;
          };
        }
        # # Command Line Tools & Customizations
        # cli.nixosModules.default
        # # Desktop Environment
        # niri.nixosModules.default
        # # AI Art Generator
        # inputs.invokeai.nixosModules.invokeai-nvidia
        # {
        #   services.invokeai = {
        #     enable = true;
        #   };
        # }
      ];
    };
  };
}
