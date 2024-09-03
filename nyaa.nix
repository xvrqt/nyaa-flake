# My primary desktop
{pkgs, ...}: {
  imports = [
    # Include the results of the hardware scan.
    ./nixos/hardware-configuration.nix
    # Include custom hardware configurations
    ./nixos/hardware.nix
    # Include the device to filesystem mapping
    ./nixos/filesystems.nix
    # Include the boot settings (some are auto-generated in ./hardware-configuration.nix)
    ./nixos/boot.nix
    # Remotely mount some filesystems
    ./nixos/smb.nix
  ];

  rust = {
    enable = true;
    flavor = "stable";
  };

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  qt.enable = true;

  # Need to review this
  xdg = {
    autostart.enable = true;
    portal = {
      enable = true;
      config.common.default = "*";
      extraPortals = [pkgs.xdg-desktop-portal-gtk];
    };
  };

  hardware.bluetooth.settings = {
    general.enable = "Source,Sink,Media,Socket";
  };
  services = {
    # Bluetooth GUI application
    blueman.enable = true;

    # Depended on by the NVIDIA kernel module, but not used
    libinput.enable = true;
    xserver = {
      enable = true;
      autorun = true;
      xkb = {
        variant = "";
        options = "caps:swapescapes";
        layout = "us";
      };
      videoDrivers = ["nvidia"];
      excludePackages = [pkgs.xterm];
      # Do not start the lightDM ;::; launch into a TTY
      displayManager.startx.enable = true;
      desktopManager.plasma5.enable = true;
      # displayManager.gdm.wayland = false;
    };

    # So I don't have to login to my own shell
    getty = {
      autologinUser = "amy";
    };

    # Start and SSH server, and set up known keys
    # Break this out, add secrets eventually
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
      };
    };

    # Audio
    pipewire = {
      enable = true;

      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;

      wireplumber = {
        extraConfig = {
          bluez_monitor.properties = {
            "bluez5.enable-sbc-xq" = true;
            "bluez5.enable-msbc" = true;
            "bluez5.enable-hw-volume" = true;
            "bluez5.headset-roles" = ["hsp_hs" "hsp_ag" "hfp_hf" "hfp_ag"];
          };
        };
      };
    };
  };

  programs = {
    zsh.enable = true;
    nix-ld = {
      enable = true;
      libraries = with pkgs; [
        stdenv.cc.cc
        zlib
        fuse3
        icu
        nss
        openssl
        curl
      ];
    };
    steam = {
      enable = true;
      gamescopeSession.enable = true;
    };

    gamescope.enable = true;

    gamemode.enable = true;

    # Git for maintaining Flakes
    git = {
      enable = true;
    };
  };

  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
    };
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
    # These packages are automatically available to all users
    systemPackages = [
      # Default text editor
      pkgs.neovim
      pkgs.freecad
      pkgs.orca-slicer
      pkgs.wayland-scanner
      pkgs.alacritty
      # (pkgs.blender.override {
      #   cudaSupport = true;
      #   waylandSupport = true;
      # })
      # pkgs.librewolf

      pkgs.turbovnc
      pkgs.pavucontrol
      pkgs.liquidctl
      pkgs.i2c-tools
      #inputs.neovim-flake.packages.x86_64-linux.default
      # Pretty print system information upon shell login
      #pkgs.neofetch
      #inputs.invokeai.packages.${pkgs.system}.invokeai-nvidia
      pkgs.waypipe
      pkgs.xorg.xauth
      pkgs.xwayland
      pkgs.glfw-wayland
      pkgs.qt6.full
      # pkgs.SDL2
      #pkgs.glfw
      # pkgs.wayland.dev
    ];

    # Permissible login shells (sh is implicitly included)
    shells = [pkgs.zsh pkgs.bash pkgs.fish pkgs.nushell];
  };

  # Networking
  # Probably more specifics I can add here
  networking = {
    hostName = "nyaa";
    networkmanager.enable = true;
    nameservers = ["1.1.1.1" "9.9.9.9"];

    firewall = {
      enable = false;
      allowedTCPPorts = [80 2049];
    };
  };

  # Security
  security = {
    sudo = {
      enable = true;
      # Don't challenge memebers of 'wheel'
      wheelNeedsPassword = false;
    };

    # Unlikely to be attacked in this way; performance improvements
    allowSimultaneousMultithreading = true;

    # For pipewire
    # Not entirely sure what this does
    rtkit.enable = true;
  };

  users = {
    # Users & Groups reset on system activation, cannot be changed while running
    mutableUsers = false;
    users = {
      amy = {
        # Default Shell
        shell = pkgs.zsh;
        # Not used, we're going to use home-manager for this
        packages = [pkgs.zsh pkgs.nushell];
        # Used by the system in various places (e.g. login screen)
        description = "Amy";
        # Added to the list of sudoers
        extraGroups = ["networkmanager" "wheel"];
        # Is not a system/daemon/program/bin in a trenchcoat
        isNormalUser = true;
        # Password for the user
        hashedPassword = "$y$j9T$aclS.QcZOPfxXBn3pa7aN/$cjLpl6MrpmGmCzQRWQxLW9HDEKxhOnWLPCqMSvFqUR.";
        # Key that allows you to log in as the user
        openssh = {
          authorizedKeys.keys = [
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEm1MGtHVfe1pHkjaCVEIFXZDtLqjvhEfbOCGV+9ZiGn amy"
            "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEfLg2pqN8cfKT6+E8rLEVMWZ/Xddh6gq8dxtV7OAIZq amy@xvrqt.com"
          ];
        };
      };

      root = {
        # Default Shell
        shell = pkgs.zsh;
        # Not used, we're going to use home-manager for this
        packages = [];
        # Added to the list of sudoers
        extraGroups = ["networkmanager" "wheel"];
        # Password for the user
        hashedPassword = "$y$j9T$aclS.QcZOPfxXBn3pa7aN/$cjLpl6MrpmGmCzQRWQxLW9HDEKxhOnWLPCqMSvFqUR.";
      };
    };
  };

  # Not entirely sure what this does
  security = {
    pam.services.swaylock = {
      text = ''
        auth include login
      '';
    };
  };

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Get specific with formatting
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
