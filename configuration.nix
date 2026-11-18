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
    extraGroups = [
      "wheel"
      "dialout"
      "libvirtd"
    ];
    packages = with pkgs; [
      tree
    ];
    shell = pkgs.fish;
  };

  # Build dir
  nix.settings.build-dir = "/home/nix-build";

  # Keep rebuilds working on small root partitions by triggering GC early.
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
    substituters = [ "https://nix-gaming.cachix.org" ];
    trusted-public-keys = [ "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4=" ];

    # If free space drops under min-free, Nix GC runs until max-free is reached.
    min-free = 5 * 1024 * 1024 * 1024;
    max-free = 12 * 1024 * 1024 * 1024;

    # Do not retain extra build history unnecessarily.
    keep-derivations = false;
    keep-outputs = false;
  };

  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 7d";
  };

  systemd.tmpfiles.rules = [
    "d /home/nix-build 0755 root root -"
  ];
  
  system.stateVersion = "26.05";
}
