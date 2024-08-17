{ pkgs, ... }:

let
  hostname = builtins.getEnv "HOSTNAME";
  nixos-rebuild = "${pkgs.nixos-rebuild}/bin/nixos-rebuild";
in 
  # Tests current flake configuration, outputs diffs of changes
  pkgs.writeShellScriptBin "nyx-dry" ''
    if [ "$1" ]; then
      sudo ${nixos-rebuild} dry-activate --flake "/flake#$1"
    else
      sudo ${nixos-rebuild} dry-activate --flake "/flake#${hostname}"
    fi
  ''

