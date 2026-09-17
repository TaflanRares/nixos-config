{ config, lib, pkgs, inputs, ...}:

{

  # Automount
  services.udiskie = {
    enable = true;
    automount = true;
    notify = true; 
  };

  # TUI file manager
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;

    settings = {
      manager = {
        show_hidden = true;
        sort_by = "natural";
        sort_dir_first = true;
      };
    };
  
    # Plugins from pkgs.yaziPlugins
    plugins = {
      inherit (pkgs.yaziPlugins) mount;
    };

    keymap = {
      mgr.prepend_keymap = [
        { on = [ "M" ]; run = "plugin mount"; desc = "Mount/unmount device"; }
        { on = [ "m" "j" ]; run = "plugin mount jump"; desc = "Jump to mounted device"; }
      ];
    };

    flavors = { inherit (pkgs.yaziPlugins) nord; };
    theme.flavor.dark = "nord";
  };

}
