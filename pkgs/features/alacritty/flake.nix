{
  inputs = {};

  outputs = _: {
    home-manager-module = {pkgs, ...}: {
      home = {
        # We're not using the "program.alacritty" version because
        # I'm having trouble with the nix-settings instead of raw yml
        packages = [pkgs.alacritty];
        file = {
          ".config/alacritty/alacritty.yml".source = ./alacritty.yml;
          ".config/alacritty/theme.yml".source = ./themes/catppuccin-mocha.yml;
        };
      };
    };
  };
}
