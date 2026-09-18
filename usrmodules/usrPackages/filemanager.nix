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

      # Opener
      opener = {
        nvim = [
          { run = "nvim \"$@\""; block = true; desc = "Open in Neovim"; }
        ];
        noop = [
          { run = "true"; orphan = true; desc = "Do nothing"; }
        ];
      };

      # Open Rules
      open = {
        rules = [
          # Catch directories and do nothing
          { mime = "inode/directory"; use = "noop"; }
          # Default fallback
          { mime = "*"; use = "nvim"; }
        ];
      };
    };
  
    # Plugins from pkgs.yaziPlugins
    plugins = with pkgs.yaziPlugins; {
      mount.package = mount;
      git.package = git;
    };

    keymap = {
      mgr.prepend_keymap = [
        { on = [ "M" ]; run = "plugin mount"; desc = "Mount/unmount device"; }
        { on = [ "m" "j" ]; run = "plugin mount jump"; desc = "Jump to mounted device"; }

        { on = [ "<Enter>" ]; run = "open"; desc = "Open file"; }
      ];
    };

    flavors = { 
      inherit (pkgs.yaziPlugins) nord; 
    };
    theme.flavor.dark = "nord";
  };

  # Cd to yazi current dir on quit
  programs.fish.functions = {
    yy = ''
      set tmp (mktemp -t "yazi-cwd.XXXXXX")
      yazi $argv --cwd-file="$tmp"
      if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
      end
      rm -f -- "$tmp"
    '';
  };
}
