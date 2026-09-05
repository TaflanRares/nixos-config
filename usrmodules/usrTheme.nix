{ config, lib, pkgs, ...}:

{
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    iconTheme = {
      name = "Adwaita";
      package = pkgs.adwaita-icon-theme;
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
    style.name = "adwaita-dark";
  };
  
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Adwaita-dark";
    };
  };

  home.sessionVariables = {
    GTK_THEME = "Adwaita-dark";
    STEAM_EXTRA_COMPAT_TOOLS_PATHS = 
      "/home/rares/.steam/root/compatibilitytools.d";
  };
}
