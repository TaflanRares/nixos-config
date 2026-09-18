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

    # Python & Docs (Unified)
    (python3.withPackages (ps: with ps; [
      pip
      virtualenv
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

  ];
}
