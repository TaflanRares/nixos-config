{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nodejs
    gcc
    cmake
    gnumake
    rustup
  ];
}
