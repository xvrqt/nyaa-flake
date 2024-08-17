{pkgs, ...}: {
  home.packages = [
    # Calls upon an llm to provide a personalize prophecy
    (pkgs.callPackage ./llm-prophecy.nix {inherit pkgs;})
    # 'nyx-update' updates the flake lock file located at /flake
    (pkgs.callPackage ./nix-update-flakes.nix {inherit pkgs;})
    # 'nyx-boot' creates a boot entry based of the flake located at /flake
    (pkgs.callPackage ./nix-boot.nix {inherit pkgs;})
    # 'nyx-switch' create and switch to a boot entry based of the flake located at /flake
    (pkgs.callPackage ./nix-switch.nix {inherit pkgs;})
    # 'nyx-dry' dry activation of the flake located at /flake
    (pkgs.callPackage ./nix-dryrun.nix {inherit pkgs;})
    # 'nyx-cleanup' deletes all unreachable objects in the nix store
    (pkgs.callPackage ./nix-collect-garbage.nix {inherit pkgs;})
    # 'nyx-user' switchs home-manger configurations to the <user>
    (pkgs.callPackage ./home-manager-switch.nix {inherit pkgs;})
  ];
}
