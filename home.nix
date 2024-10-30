{pkgs, ...}: {
  imports = [
    # Customize my NeoVim (nvf flake)
  ];
  # God's own perfect angel
  home = {
    username = "amy";
    #stateVersion = "24.05";
    stateVersion = "24.11";
    homeDirectory = "/home/amy";

    sessionVariables = {};

    # Additional Packages
    packages = [
      # Audio something something pkgs.wireplumber
      #
      # pkgs.termusic
      pkgs.glxinfo
      pkgs.kitty
      #      pkgs.amberol
      pkgs.davinci-resolve-studio
      pkgs.alacritty
      pkgs.imagemagick
      pkgs.discord
      pkgs.esshader
      pkgs.gimp-with-plugins
      pkgs.xfce.thunar
      pkgs.pkg-config
      # pkgs.wineasio
      # pkgs.winetricks
      #pkgs.wineWowPackages.stable
      # pkgs.lutris
      # pkgs.wine64
      # pkgs.wineWowPackages.waylandFull
      # pkgs.steamPackages.steamcmd
      #      pkgs.steam-tui
      #      pkgs.rustup
      pkgs.trunk
      pkgs.gamemode
      pkgs.wf-recorder
      pkgs.vlc
      pkgs.bemoji
    ];

    # Configuration files to copy to the home directory
    file = {};
  };

  # Enable our desktop environment
  # desktops = {
  #   screenshot-path = ./. + "~/Pictures/Screenshots/scrot_%Y-%m-%d-%H-%M-%S.png";
  #
  #   niri = {
  #     enable = true;
  #     monitor = "odyssey";
  #     animations.window-close.enable = true;
  #   };
  # };

  programs = {
    # Allow home-manager to manage itself
    home-manager = {
      enable = true;
    };

    librewolf = {
      enable = true;
      settings = {
        "webgl.disabled" = false;
        "privacy.resistFingerprinting" = false;
        "privacy.clearOnShutdown.history" = false;
        "privacy.clearOnShutdown.cookies" = false;
      };
    };
    termusic.enable = false;

    mangohud.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      enableNushellIntegration = true;
    };

    # eza.enableAliases = false;

    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        # obs-backgroundremoval
        obs-pipewire-audio-capture
        # waveform
        obs-vaapi
        # obs-3d-effect
        obs-vkcapture
        input-overlay
        # advanced-scene-switcher
      ];
    };

    zsh = {
      enable = true;
    };
    zoxide.enable = false;
  };
}
