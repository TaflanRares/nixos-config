{ config, lib, pkgs, ... }:

{
  programs.nix-ld = {
    enable = true;
    # nixld, set up initially because of stm32-vscode-extension
    libraries = with pkgs; [
      stdenv.cc.cc
      zlib
      openssl
      curl
      icu
      expat
      libusb1
      udev
      systemd
    ];
  };
}
