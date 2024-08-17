{
  inputs = {
    # Useful command line tools
    #cli.url = "./cli";

    # Termincal emulator
    alacritty.url = "./alacritty";

    # Large Language Models
    llm.url = "./llm";

    # Enable finding userland fonts, and install some nice fonts
    fonts.url = "./fonts";

    # 3D Modeling Program
    blender.url = "./blender";
  };

  outputs = {
    llm,
    fonts,
    blender,
    alacritty,
    ...
  }: {
    inherit llm fonts blender alacritty;

    # Customized Firefox Web Browser fork
    librewolf.home-manager-module = import ./librewolf.nix;
  };
}
