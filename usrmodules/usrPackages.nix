{ config, lib, pkgs, inputs, ...}:

let
  dotfiles = "${config.home.homeDirectory}/dotfiles-nix/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

  configs = {
    nvim = "nvim-config";
    hypr = "hypr-config";
  };

in 
{
  # User-specific packages   
  home.packages = with pkgs; [
    # Utils
    nixpkgs-fmt
    neovim
    ripgrep
    nil
    yt-dlp
    # Secrets
    libsecret
    # Zen browser
    inputs.zen-browser.packages.${pkgs.system}.default
    # Dev
    nodejs
    gcc
    cmake
    gnumake
    rustup
    # Gaming
    protonup-ng
    mangohud
    prismlauncher
  ];

  imports =
  [
    ./usrPackages
  ];

  programs.obs-studio = {
    enable = true;

    # Nvidia hardware acceleration
    package = (
      pkgs.obs-studio.override {
        cudaSupport = true;
      }
    );

    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-backgroundremoval
      obs-pipewire-audio-capture 
      obs-gstreamer
      obs-vkcapture
    ];
  };

  # Secrets
  programs.keepassxc = {
    enable = true;
    autostart = true;
    settings = {
      FdoSecrets.Enabled = true;
      SSHAgent = {
        Enabled = true;
        AuthSockOverride = "/run/user/1000/ssh-agent";
      };
      GUI = {
        MinimizeOnClose = true;
        ShowTrayIcon = true;
        ApplicationTheme = "dark";
      };
    };
  };

  # btop resource manager
  programs.btop.enable = true;

  # Config files
  xdg.configFile = builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
    })
    configs;
}
