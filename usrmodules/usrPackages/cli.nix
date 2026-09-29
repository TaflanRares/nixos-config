{ config, pkgs, ... }:

{
  # ripgrep
  programs.ripgrep = {
    enable = true;
    arguments = [ "--smart-case" ];
  };
  programs.ripgrep-all.enable = true;

  # find
  programs.fd = {
    enable = true;
    hidden = true;
    ignores = [ ".git/" ];
  };

  # cat
  programs.bat.enable = true;

  # ls
  programs.eza = {
    enable = true;
    git = true;
    icons = "auto";
  };

  # fzf
  programs.fzf = {
    enable = true;
    defaultCommand = "fd --type f";
    fileWidgetOptions = [ "--preview 'bat -n --color=always {}'" ];
    changeDirWidgetOptions = [ "--preview 'eza --tree --color=always {} | head -200'" ];
  };

  # cd
  programs.zoxide = {
    enable = true;
    options = [ "--cmd" "cd" ];
  };

  home.packages = with pkgs; [
    jq
    dust
    tealdeer
    hexyl
  ];
}
