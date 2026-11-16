{ config, lib, pkgs, ... }:

{
  services.udev.packages = [
    pkgs.stlink
  ] ++ lib.optionals (!config.custom.minimalBuild.enable) [
    (pkgs.callPackage ../usrmodules/devPackages/stm32cubeprog.nix {})
  ];
}
