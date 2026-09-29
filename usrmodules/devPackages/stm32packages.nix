{ config, lib, pkgs, ... }:

{
  options.custom.stm32.enable = lib.mkEnableOption "STM32 tooling (CubeMX, CubeProgrammer)" // {
    default = true;
  };

  config = lib.mkIf config.custom.stm32.enable {
    home.packages = [
      (pkgs.callPackage ./stm32cubeprog.nix {})
      (pkgs.callPackage ./stm32cubemx.nix {})
    ];
  };
}
