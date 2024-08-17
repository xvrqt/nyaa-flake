{
  inputs = {};

  outputs = _: {
    home-manager-module = import ./scripts.nix;
  };
}
