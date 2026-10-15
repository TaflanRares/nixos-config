{ pkgs, lib, ... }:

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

    # Debugging
    (lib.lowPrio gdb)

    # Arduino
    arduino-ide
    arduino-cli

    # Python & Docs
    (python3.withPackages (ps: with ps; [
      pip
      virtualenv
      # maths
      numpy
      pandas
      matplotlib
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

    # DB / SQL
    dbeaver-bin

    # QtSpim MIPS
    (pkgs.symlinkJoin {
      name = "qtspim-light";
      paths = [ pkgs.qtspim ];
      nativeBuildInputs = [ pkgs.makeWrapper ];
      postBuild = ''
        wrapProgram $out/bin/qtspim \
          --unset QT_QPA_PLATFORMTHEME \
          --set QT_STYLE_OVERRIDE Fusion \
          --set GTK_THEME Adwaita
      '';
    })

    # Language servers
    nil                           # nix    lsp
    basedpyright                  # python lsp
    ruff                          # python linter
    lua-language-server           # lua    lsp
    vscode-langservers-extracted  # web    lsp

    # Coms packages
    savvycan  # CAN
    can-utils # CAN
    libftdi   # FDI boards
    libusb1   # USB utils

  ];
}
