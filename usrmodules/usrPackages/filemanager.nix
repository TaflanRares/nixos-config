{ config, lib, pkgs, inputs, ...}:

{

  # Let Exo/Thunar resolve TerminalEmulator to alacritty.
  home.file.".config/xfce4/helpers.rc".text = ''
    TerminalEmulator=alacritty
    TerminalEmulatorDismissed=true
  '';

  # Special user dirs (documents/desktop/etc)
  xdg.userDirs = {
    enable = true;
  };

  # Automount
  services.udiskie = {
    enable = true;
    automount = true;
    notify = true; 
  };

  # TUI file manager
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;

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
      clipboard.package = clipboard;
    };

    keymap = {
      mgr.prepend_keymap = [
        { on = [ "M" ]; run = "plugin mount"; desc = "Mount/unmount device"; }
        { on = [ "m" "j" ]; run = "plugin mount jump"; desc = "Jump to mounted device"; }
        { on = [ "y" ]; run = [ "yank" "plugin clipboard -- --action=copy" ]; desc = "Yank selected files (copy + system clipboard)"; }
        { on = [ "x" ]; run = [ "yank --cut" "plugin clipboard -- --action=copy" ]; desc = "Yank selected files (cut + system clipboard)"; }
        { on = [ "<C-p>" ]; run = "plugin clipboard -- --action=paste"; desc = "Paste files from system clipboard"; }

        { on = [ "<Enter>" ]; run = "open"; desc = "Open file"; }
      ];
    };

    flavors = { 
      inherit (pkgs.yaziPlugins) nord; 
    };
    theme.flavor.dark = "nord";
  };

  # Cd to yazi current dir on quit
  programs.zsh.initContent = ''
    yy() {
      local tmp cwd
      tmp="$(mktemp -t yazi-cwd.XXXXXX)"
      yazi "$@" --cwd-file="$tmp"
      if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd"
      fi
      rm -f -- "$tmp"
    }
  '';
}
