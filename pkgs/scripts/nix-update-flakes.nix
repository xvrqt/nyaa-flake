{ pkgs, ... }:

# Updates the all flakes (programs) for the flake located at 'flake'
## Todo: Open interactive menu for individual updating
pkgs.writeShellScriptBin "nyx-update" ''
  sudo ${pkgs.nix}/bin/nix flake update "/flake"
''

