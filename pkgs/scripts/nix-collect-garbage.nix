{ pkgs, ... }:

let
  nix-store = "${pkgs.nix}/bin/nix-store";
in 
  # Cleans up all unreachable objects in the nix store 
  pkgs.writeShellScriptBin "nyx-cleanup" ''
    sudo ${nix-store} --gc
  ''

