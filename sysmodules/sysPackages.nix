{ inputs, config, lib, pkgs, ...}:

{
  options.custom.minimalBuild.enable = lib.mkEnableOption "minimal system build for low-space rebuilds" // {
    default = false;
  };

  config = {
    programs.fish.enable = true;

  # Nix builder
    programs.nh = {
      enable = true;
      flake = "/home/rares/dotfiles-nix";
      clean = {
        enable = true;
        extraArgs = "--keep-since 4d --keep 3";
      };
    };

    # Flatpak
    services.flatpak.enable = true;

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

      # Connection
      picocom
    ] ++ lib.optionals (!config.custom.minimalBuild.enable) [
      # Heavy imported package; excluded in minimal build.
      inputs.spotatui.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };

} 
