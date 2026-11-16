{ pkgs, ... }:

{
  # Docker
  virtualisation.docker = {
    enable = true;
    daemon.settings.data-root = "/home/docker";
  };

  virtualisation.oci-containers = {
    backend = "docker";
    containers.oracle-xe = {
      image = "gvenzl/oracle-xe:21-slim";
      ports = [ "127.0.0.1:1521:1521" ];
      # ORACLE_PASSWORD=...
      environmentFiles = [ "/home/rares/.secrets/oracle-xe.env" ];
      volumes = [ "oracle-xe-data:/opt/oracle/oradata" ];
      autoStart = false;
    };
  };

  # Virtual Machine
  virtualisation.libvirtd = {
    enable = true;
    qemu.swtpm.enable = true;
  };

  # Virtualisation related patches
  virtualisation.podman = {
    enable = true;
  };    

  programs.virt-manager.enable = true;

  environment.systemPackages = [ pkgs.virtio-win ];

  # Optional: USB passthrough (e.g. ST-Link into the guest)
  # virtualisation.spiceUSBRedirection.enable = true;
}
