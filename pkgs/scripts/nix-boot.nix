{ pkgs, ... }:

let
  hostname = builtins.getEnv "HOSTNAME";
  nixos-rebuild = "${pkgs.nixos-rebuild}/bin/nixos-rebuild";
in 
  # Tests current flake configuration, outputs diffs of changes
  pkgs.writeShellScriptBin "nyx-boot" ''
    if [ "$1" ]; then
      sudo ${nixos-rebuild} boot --flake "/flake#$1"
    else
      sudo ${nixos-rebuild} boot --flake "/flake#${hostname}"
    fi
  ''

