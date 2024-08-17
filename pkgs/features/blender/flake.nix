{
  inputs = {
    blender.url = "github:edolstra/nix-warez?dir=blender";
  };

  outputs = {blender, ...}: {
    inherit blender;
    homeManagerModules.default = import ./blender.nix;
  };
}
