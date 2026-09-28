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

  # Flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  system.stateVersion = "26.05";
}
