{ config, lib, pkgs, ... }:

{
  programs.nix-ld = {
    enable = true;
    # nixld, set up initially because of stm32-vscode-extension
    libraries = with pkgs; [
      zlib
      zstd
      stdenv.cc.cc
      curl
      openssl
      attr
      libssh
      bzip2
      libxml2
      acl
      libsodium
      util-linux
      xz
      systemd
      libusb1
    ];
  };
}