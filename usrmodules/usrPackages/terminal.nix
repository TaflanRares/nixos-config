{ ... }:

{
  # Terminal + shell
  programs.kitty = {
    enable = true;
    settings = {
      font_family = "JetBrainsMono Nerd Font";
      font_size = 12;

      copy_on_select = "yes";
      click_url_on_modifier = "ctrl";
      url_style = "curly";

      background_opacity = "0.85";
      dynamic_background_opacity = "yes";

      cursor_shape = "beam";
      cursor_blink_interval = 0;
    };

    shellIntegration.enableZshIntegration = true;
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

    shellAliases = {
      icat = "kitty +kitten icat";
    };
  };

  xdg.desktopEntries.zsh = {
    name = "Zsh";
    genericName = "Shell";
    comment = "Open Zsh in Kitty";
    exec = "kitty -e zsh";
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
