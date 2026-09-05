{ config, pkgs, ... }:

{
  # Kitty and fish
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

    shellIntegration.enableFishIntegration = true;
  };

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      # Greet w fastfetch
      set -g fish_greeting ""
      fastfetch
    '';

    functions = {
      fish_prompt = ''
        # pwd, white background 
        set_color -b 99ffcc 000000 -o
        echo -n ' '
        echo -n (prompt_pwd)
        echo -n ' '

        # right arrow
        set_color -b normal 99ffcc
        echo -n " "

        # reset text color
        set_color normal
      '';
    };

    shellAliases = {
      icat = "kitty +kitten icat";
      nixrebuild = "nixos-rebuild switch --flake ~/dotfiles-nix#nixflake";
    };
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
}
