{
  inputs = {};

  outputs = _: {
    home-manager-module = {pkgs, ...}: {
      home.packages = [
        pkgs.ollama
      ];
    };
  };
}
