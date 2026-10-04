{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ./sysmodules
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    timeout = 0;
  };
  boot.kernelModules = [ "can" "can_raw" "slcan" ];

  networking.hostName = "nixflake";
  networking.networkmanager.enable = true;

  # Firewall 
  networking.firewall = {
    enable = true;
    allowPing = false;
    allowedTCPPorts = [ ];
    allowedUDPPorts = [ ];
  };

  time.timeZone = "Europe/Bucharest";

  # User account
  users.users.rares = {
    isNormalUser = true;
    extraGroups = [ "wheel" "dialout" ];
    packages = with pkgs; [
      tree
    ];
    shell = pkgs.fish;
  };

  # Build dir
  nix.settings.build-dir = "/home/nix-build";

  systemd.tmpfiles.rules = [
    "d /home/nix-build 0755 root root -"
  ];

  # Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  system.stateVersion = "26.05";
}
