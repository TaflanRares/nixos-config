{ ... }:

{
  # Terminal + shell
  programs.alacritty = {
    enable = true;
    settings = {
      window.opacity = 0.78;

      colors = {
        primary = {
          background = "0x050505";
          foreground = "0xe6edf3";
        };

        normal = {
          black = "0x1b1f2a";
          red = "0xff6b6b";
          green = "0x7ee787";
          yellow = "0xf2cc60";
          blue = "0x79c0ff";
          magenta = "0xd2a8ff";
          cyan = "0x56d4dd";
          white = "0xc9d1d9";
        };

        bright = {
          black = "0x4b5563";
          red = "0xff7b72";
          green = "0x8ddb8c";
          yellow = "0xffd866";
          blue = "0x8cc8ff";
          magenta = "0xe2b5ff";
          cyan = "0x6fe3ea";
          white = "0xf0f6fc";
        };
      };

      font = {
        normal.family = "JetBrainsMono Nerd Font";
        size = 12;
      };

      selection.save_to_clipboard = true;

      keyboard.bindings = [
        # Keep standard terminal shortcuts explicit.
        { key = "V"; mods = "Control|Shift"; action = "Paste"; }
        { key = "Insert"; mods = "Shift"; action = "Paste"; }
        { key = "C"; mods = "Control|Shift"; action = "Copy"; }

        # Convenience: allow Ctrl+V paste directly.
        { key = "V"; mods = "Control"; action = "Paste"; }
      ];

      hints.enabled = [
        {
          regex = "((https?|ftp|file)://|mailto:)[^[:space:]<>\"`]+";
          hyperlinks = true;
          command = "xdg-open";
          post_processing = true;
          mouse = {
            enabled = true;
            mods = "Control";
          };
        }
      ];

      cursor.style = {
        shape = "Beam";
        blinking = "Off";
      };
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initContent = ''
      # Bash-style completion compatibility.
      autoload -U +X bashcompinit && bashcompinit

      # Completion UI
      zstyle ':completion:*' menu select
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

      # Prompt with PWD segment + separator.
      PROMPT='%K{#99ffcc}%F{#000000}%B %~ %b%f%k%F{#99ffcc} %f'
    '';

  };

  xdg.desktopEntries.zsh = {
    name = "Zsh";
    genericName = "Shell";
    comment = "Open Zsh in Alacritty";
    exec = "alacritty -e zsh";
    icon = "utilities-terminal";
    terminal = false;
    categories = [ "System" "Utility" "TerminalEmulator" ];
  };

  # Git
  programs.git = {
    enable = true;
    settings = {
      user.name  = "TaflanRares";
      user.email = "taflan.r@yahoo.com";
      
      init.defaultBranch = "master";
      core.editor = "nvim";

      alias = {
        st = "status";
        br = "branch";
        co = "checkout";
      };
    };

    ignores = [
      "*~"
      "*.swp"
    ];
  };

  # Git diff
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };

  # Git TUI
  programs.lazygit = {
    enable = true;
    settings.git.pagers = [
    {
      colorArg = "always";
      pager = "delta --dark --paging=never";
    }
    ];
  };

}
