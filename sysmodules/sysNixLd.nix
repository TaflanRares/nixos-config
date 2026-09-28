{ config, lib, pkgs, ... }:

{
  programs.nix-ld = {
    enable = true;
    # nix-ld, set up for vsc and stm32cube
    libraries = with pkgs; [
      stdenv.cc.cc
      stdenv.cc.cc.lib
      zlib
      zstd
      brotli
      glib
      openssl
      curl
      icu
      expat
      libusb1
      udev
      systemd
      libkrb5
      pcsclite
      libx11
    ];
  };
}
