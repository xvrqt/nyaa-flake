_: {
  # Mount the user files to their own NVME M.2 2TiB device [nvme1n1p1]
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/18539642-0193-499a-bf7c-ec20ba57bdde";
    fsType = "ext4";
  };

  # Mount the boot sector (shares device with '/nix') [nvme0n1p1]
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/B6FA-2AC0";
    fsType = "vfat";
  };

  # Mount the NixOS binary store (shares a device with '/boot') [nvme0n1p2]
  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/bfe34517-f982-4084-9770-c4c74b5ca1c7";
    fsType = "ext4";
  };
  fileSystems."/imports/music" = {
    device = "192.168.1.6:/zpools/hdd/media/music";
    fsType = "nfs";
    options = ["x-systemd.automount" "noauto" "x-systemd.idle-timeout=600"];
  };

  fileSystems."/imports/images" = {
    device = "192.168.1.6:/zpools/hdd/media/images";
    fsType = "nfs";
    options = ["x-systemd.automount" "noauto" "x-systemd.idle-timeout=600"];
  };

  fileSystems."/imports/movies" = {
    device = "192.168.1.6:/zpools/hdd/media/movies";
    fsType = "nfs";
    options = ["x-systemd.automount" "noauto" "x-systemd.idle-timeout=600"];
  };

  fileSystems."/imports/series" = {
    device = "192.168.1.6:/zpools/hdd/media/series";
    fsType = "nfs";
    options = ["x-systemd.automount" "noauto" "x-systemd.idle-timeout=600"];
  };

  fileSystems."/imports/videos" = {
    device = "192.168.1.6:/zpools/hdd/media/videos";
    fsType = "nfs";
    options = ["x-systemd.automount" "noauto" "x-systemd.idle-timeout=600"];
  };

  fileSystems."/imports/xvrqt" = {
    device = "192.168.1.6:/zpools/ssd/xvrqt";
    fsType = "nfs";
    options = ["x-systemd.automount" "noauto" "x-systemd.idle-timeout=600"];
  };
}
