{ config, lib, pkgs, ...}:

{
  programs.fish.enable = true;

  environment.systemPackages = with pkgs; [
    # Core
    vim
    wget

    # Wm
    waybar
    hyprlock
    hyprlauncher

    # Screenshot
    grim
    slurp

    # Tools
    wl-clipboard
    brightnessctl

    # Media
    pkgs.mpv
    pkgs.mpvpaper
    pkgs.feh
    imlib2

    # Music
    spotify-player

    # Utils
    ffmpeg
    libva-utils
    vdpauinfo
    pkgs.onlyoffice-desktopeditors

    # Files
    thunar
    thunar-volman
    thunar-archive-plugin
    tumbler
    ffmpegthumbnailer

    # Archive
    zip
    unzip
    p7zip

    # Gpu
    nvtopPackages.nvidia
    mesa-demos
    vulkan-tools
  ];

} 
