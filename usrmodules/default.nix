{ config, lib, ... }:

{
  options.custom.minimalBuild.enable = lib.mkEnableOption "minimal Home Manager build for low-space rebuilds" // {
    default = false;
  };

  imports = [
    ./devPackages
    ./usrPackages.nix
    ./usrTheme.nix
    ./noctalia.nix
  ];
}
