{ pkgs }:

pkgs.mkShell {
  packages = with pkgs; [
    python3
    python3Packages.pip
    python3Packages.virtualenv
    python3Packages.ipython
    ruff
    pyright
  ];
}
