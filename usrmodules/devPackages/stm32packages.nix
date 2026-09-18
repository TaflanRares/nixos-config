{ pkgs, ... }:
{
  home.packages = [ (pkgs.callPackage ./stm32cubeprog.nix {}) ];
}
