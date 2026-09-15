{ pkgs }:

pkgs.mkShell {
  packages = with pkgs; [ rustc cargo rust-analyzer clippy ];
}
