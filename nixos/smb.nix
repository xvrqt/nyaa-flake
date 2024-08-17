# Mounts my NAS samba shares
{pkgs, ...}: let
  automount_options = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
  credentials = "credentials=/etc/nixos/smb-secrets";
in {
  # Required software to mount the drives
  environment = {
    systemPackages = [
      pkgs.cifs-utils
    ];
  };

  # Movies, Shows, Music, Video, Image, Pictures, Books
  fileSystems."/NAS/media" = {
    fsType = "cifs";
    device = "//192.168.1.6/media";
    options = [
      automount_options
      credentials
    ];
  };

  # My universal home-directory
  fileSystems."/NAS/xvrqt" = {
    fsType = "cifs";
    device = "//192.168.1.6/xvrqt";
    options = [
      automount_options
      credentials
    ];
  };
}
