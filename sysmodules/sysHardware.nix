{ config, lib, pkgs, ... }:

{

  # Audio & bluetooth
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  security.rtkit.enable = true;

  # Touchpad support
  services.libinput.enable = true;

  # Power support
  services.upower.enable = true;

  # SSD trim
  services.fstrim.enable = true;

  # Graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  services.xserver.videoDrivers = ["nvidia"];
  
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    open = true;
    modesetting.enable = true;
    powerManagement.enable = true;

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };

      # integrated gpu
      amdgpuBusId = "PCI:5:0:0";
      # dedicated gpu
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  specialisation = {
    performance.configuration = {
      
      hardware.nvidia = {
        prime.sync.enable = lib.mkForce true;
        prime.offload = {
          enable = lib.mkForce false;
          enableOffloadCmd = lib.mkForce false;
        };
      };

    };
  };

}
