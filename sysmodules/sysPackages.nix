{ config, lib, pkgs, ...}:

{
  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    kitty
    waybar
    hyprlock
    hyprlauncher
    # Screenshots
    grim
    # Cursors 
    bibata-cursors
    # Functionality
    wl-clipboard
    brightnessctl
    pkgs.mpv
    pkgs.mpvpaper
    pkgs.feh
    imlib2
    # Spoty
    spotify-player
    # Utilities
    ffmpeg
    libva-utils
    vdpauinfo
    pkgs.onlyoffice-desktopeditors
    # File manager
    thunar
    thunar-volman
    thunar-archive-plugin
    tumbler
    ffmpegthumbnailer
    # Archiving
    zip
    unzip
    p7zip
    # Nvidia / GPU
    nvtopPackages.nvidia
    mesa-demos
    vulkan-tools
  ];

} 
