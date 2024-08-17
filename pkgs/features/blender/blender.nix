{
  pkgs,
  packages,
  ...
}: {
  home.packages = [
    # Necessary for Blender
    pkgs.cudatoolkit
    # Upstream Blender, configured for Wayland
    packages.features.blender.blender.packages.${pkgs.system}.default
  ];
}
