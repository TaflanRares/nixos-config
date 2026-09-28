{ pkgs, ... }:
{
  home.packages = [
    (pkgs.callPackage ./stm32cubeprog.nix {})
    (pkgs.callPackage ./stm32cubemx.nix {})
  ];
}
