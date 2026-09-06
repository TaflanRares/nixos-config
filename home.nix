{ config, pkgs, inputs, ... }:

{
  # Home
  home.username = "rares";
  home.homeDirectory = "/home/rares";
  home.stateVersion = "26.05";

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;
  };

  xdg.autostart.enable = true;
  
  wayland.windowManager.hyprland.systemd.enable = false;

  # Ssh
  services.ssh-agent.enable = true;

  imports =
  [
    ./usrmodules
  ];
}
