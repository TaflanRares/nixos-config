{ config, lib, pkgs, ... }:

{
  services.udev.packages = [
    pkgs.stlink
    (pkgs.callPackage ../usrmodules/devPackages/stm32cubeprog.nix {})
  ];
}
