{
  inputs = {
    # Desktop configurations
    #desktops.url = "./desktops";

    # Common applications
    features.url = "./features";

    # Shell Scripts
    scripts.url = "./scripts";
  };

  outputs = {
    features,
    scripts,
    ...
  }: {
    inherit features scripts;
  };
}
