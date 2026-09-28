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
    screen

    # Arduino
    arduino-ide
    arduino-cli

    # Python & Docs
    (python3.withPackages (ps: with ps; [
      pip
      virtualenv
      # serial tools
      pyserial
      # docs
      sphinx
      breathe
      sphinx-rtd-theme
      sphinx-autobuild
    ]))
    uv

    # Doxygen (docs)
    doxygen

    # Javascript
    nodejs

    # Rust
    rustup

    # KiCad
    kicad

    # Language servers
    nil       # nix

    # Coms packages
    savvycan  # CAN
    can-utils # CAN
    libftdi   # FDI boards
    libusb1   # USB utils

  ];
}
