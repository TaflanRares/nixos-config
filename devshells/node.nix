{ pkgs }:
pkgs.mkShell {
  packages = with pkgs; [
    nodejs_22
    nodePackages.npm
    nodePackages.pnpm
    yarn
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.prettier
  ];
}
