{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # C/C++
    gcc
    gnumake
    cmake
    ninja
    pkg-config

    # Embedded
    gcc-arm-embedded
    openocd
    stlink
    stm32cubemx

    # Python
    python3
    python3Packages.pip
    python3Packages.virtualenv
    uv

    # Javascript
    nodejs

    # Rust
    rustup
  ];
}
