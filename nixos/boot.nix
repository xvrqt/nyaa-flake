{
  config,
  pkgs,
  ...
}:
# Boot Settings
{
  boot = {
    # Use the latest kernel
    kernelPackages = pkgs.linuxPackages_latest;
    #kernelPackages = pkgs.linuxPackages_6_8;

    # Disables all security mitigations
    kernelParams = ["acpi_enforce_resources=lax" "nvidia-drm.modeset=1" "nvidia-drm.fbdev=1"];
    kernelModules = ["i2c-dev" "i2c-piix4"];

    loader = {
      # Seconds until the first boot entry is selected
      timeout = 25;

      # Allow NixOS to modify EFI variables
      efi.canTouchEfiVariables = true;

      # Gummiboot Settings
      systemd-boot = {
        enable = true;
        # Keep only the last 100 configurations
        configurationLimit = 2;
        # Use the highest numbered available mode for the console
        consoleMode = "max";
        # Don't allow editing the kernel before booting
        editor = false;
      };
    };

    # Modules the must load during boot
    initrd = {
      enable = true;
      # Other modules are detected and included by './hardware-configuration.nix'
      kernelModules = [
        # GPU
        "nvidia"
        # Intel CPU Temperature Monitoring
        "coretemp"
      ];
    };

    # Annotate why these are important
    extraModulePackages = [
      config.boot.kernelPackages.nvidia_x11_beta
      config.boot.kernelPackages.v4l2loopback
    ];
  };
}
