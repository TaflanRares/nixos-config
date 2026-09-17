{ inputs, config, lib, pkgs, ...}:

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

    # Functionalities
    wl-clipboard
    brightnessctl
    usbutils

    # Media
    pkgs.mpv
    pkgs.mpvpaper
    pkgs.feh
    imlib2

    # Utils
    ffmpeg
    libva-utils
    vdpauinfo
    pkgs.onlyoffice-desktopeditors

    # Files
    thunar
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

    # Spotify player
    inputs.spotatui.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

} 
