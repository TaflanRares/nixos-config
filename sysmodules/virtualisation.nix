{ pkgs, ... }:

{
  virtualisation.libvirtd = {
    enable = true;
    qemu.swtpm.enable = true;
  };

  programs.virt-manager.enable = true;

  users.users.rares.extraGroups = [ "libvirtd" ];

  environment.systemPackages = [ pkgs.virtio-win ];

  # Optional: USB passthrough (e.g. ST-Link into the guest)
  # virtualisation.spiceUSBRedirection.enable = true;
}
