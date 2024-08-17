{ pkgs, ... }:

let
  hostname = builtins.getEnv "HOSTNAME";
  nixos-rebuild = "${pkgs.nixos-rebuild}/bin/nixos-rebuild";
in 
  # Creates a boot entry from the current flake and switches to it
  pkgs.writeShellScriptBin "nyx-switch" ''
    if [ "$1" ]; then
      sudo ${nixos-rebuild} switch --flake "/flake#$1"
    else
      sudo ${nixos-rebuild} switch --flake "/flake#${hostname}"
    fi
  ''

