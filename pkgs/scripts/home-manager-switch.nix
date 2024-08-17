{pkgs, ...}: let
  username = builtins.getEnv "USER";
  home-manager = "${pkgs.home-manager}/bin/home-manager";
in
  # Tests current flake configuration, outputs diffs of changes
  pkgs.writeShellScriptBin "nyx-user" ''
    if [ "$1" ]; then
      ${home-manager} switch --flake "/flake#$1"
    else
      ${home-manager} switch --flake "/flake#${username}"
    fi
  ''
