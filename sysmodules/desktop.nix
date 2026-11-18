{ config, lib, pkgs, inputs, ...}:

{
  imports = [
    inputs.noctalia-greeter.nixosModules.default
    inputs.nix-gaming.nixosModules.platformOptimizations
    inputs.nix-gaming.nixosModules.pipewireLowLatency
  ];

  # Hyrpland
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };

  # Dconf
  programs.dconf.enable = true;

  # XDG portal
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-hyprland];
  };

  # Greeter
  services.displayManager = {
    defaultSession = "hyprland";
  };
 
  services.greetd.enable = true;security.polkit.enable = true;
  services.displayManager.noctalia-greeter = {
    enable = true;
    settings = {
      session.default = "Hyprland (uwsm-managed)";
      user.default = "rares";
      cursor = {
        theme = "Bibata-Modern-Ice";
        size = 24;
        path = "${pkgs.bibata-cursors}/share/icons";
      };
      keyboard = {
        numlock = true;
      };
    };
  };
 
  # Steam
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
    platformOptimizations.enable = true;
  };
  programs.gamemode.enable = true;

  services.pipewire.lowLatency = {
    enable = true;
    quantum = 128;
    rate = 48000;
  };

  # Fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.droid-sans-mono
    corefonts
  ];

}
