{
  pkgs,
  config,
  inputs,
  ...
}: {
  services.xserver.videoDrivers = ["nvidia"];
  services.hardware.openrgb.enable = true;
  services.hardware.openrgb.motherboard = "intel";
  services.hardware.openrgb.package = pkgs.openrgb-with-all-plugins;
  programs.coolercontrol.enable = true;
  programs.coolercontrol.nvidiaSupport = true;

  # Hardware configurations (hardware-configurations.nix is auto generated by NixOS)
  hardware = {
    enableAllFirmware = true;

    # CPU
    cpu.intel = {
      updateMicrocode = true;
    };

    # AIO CPU Liquid Cooler Controller
    gkraken.enable = true;
    i2c.enable = true;

    # GPU
    nvidia = {
      # Use proprietary kernel modules
      open = false;
      # Use the beta driver (increases compatibility with many packages, DE/WM)
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      # Add Nvidia's GPU configuration tool to the system
      nvidiaSettings = true;
      # Allows the kernel to use the GPU during boot, among other things
      modesetting.enable = true;
      # Save VRAM state during system suspend and hibernate operations
      powerManagement.enable = false;
      # Reduces screen tearing (4090 can easily handle extra load)
      forceFullCompositionPipeline = true;
    };

    # OpenGL
    graphics = {
      enable = true;
      enable32Bit = true;

      # Should add why this is important for the GPU
      extraPackages = [
        pkgs.vaapiIntel
        pkgs.vaapiVdpau
        pkgs.libvdpau-va-gl
        pkgs.mesa.drivers
        pkgs.libva-utils
        pkgs.vdpauinfo
        pkgs.vulkan-tools
        pkgs.vulkan-validation-layers
        pkgs.egl-wayland
        pkgs.wgpu-utils
        pkgs.mesa
        pkgs.libglvnd
        pkgs.nvtopPackages.full
        pkgs.nvitop
        pkgs.libGL
        pkgs.cudatoolkit
      ];
    };

    # Devices
    sensor = {
      hddtemp = {
        # Monitore HDD Temperatures
        enable = true;
        # Which drives to monitor
        drives = ["/dev/disk/nvme0" "/dev/disk/nvme1"];
        # Termperature Unit of Measurement
        unit = "C";
      };
    };

    # Bluetooth
    bluetooth = {
      enable = true;
      powerOnBoot = true;

      # Enable A2DP Sinks
      settings = {
        general = {
          enable = "Source,Sink,Media,Socket";
        };
      };
    };
  };
}
