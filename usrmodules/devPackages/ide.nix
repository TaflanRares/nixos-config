{ config, pkgs, inputs, ... }:

let
  vscodeMarketplaceExtensions = inputs.nix-vscode-extensions.extensions.${pkgs.system};
in
{
  programs.vscode = {
    enable = true;
    profiles.default.extensions = with pkgs.vscode-extensions; [
      dracula-theme.theme-dracula
      vscodevim.vim
      yzhang.markdown-all-in-one
      sumneko.lua
    ] ++ (with vscodeMarketplaceExtensions.vscode-marketplace; [
      bbenoist.nix
    ]);
  };
  
}
