{ config, lib, pkgs, inputs, ... }:

let
  vscodeMarketplaceExtensions = inputs.nix-vscode-extensions.extensions.${pkgs.stdenv.hostPlatform.system};

  unfreePkgs = import pkgs.path {
    inherit (pkgs) system;
    config.allowUnfree = true;
  };
in
{

  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;

    profiles.default.extensions = with pkgs.vscode-extensions; [
      # Vimotions
      vscodevim.vim
      # Markdown
      yzhang.markdown-all-in-one
      # Lua
      sumneko.lua

    ] ++ (with unfreePkgs.vscode-extensions; [
      # CPP MS (unfree)
      ms-vscode.cpptools

    ]) ++ (with vscodeMarketplaceExtensions.vscode-marketplace; [
      # CPP MS
      ms-vscode.cpptools-themes
      ms-vscode.cpp-devtools
      ms-vscode.cmake-tools
      # Debugging
      marus25.cortex-debug
      eclipse-cdt.memory-inspector
      eclipse-cdt.serial-monitor
      mcu-debug.debug-tracker-vscode
      mcu-debug.memory-view
      mcu-debug.rtos-views
      mcu-debug.peripheral-viewer
      # STM32Cube
      stmicroelectronics.stm32cube-ide-core
      stmicroelectronics.stm32cube-ide-rtos
      stmicroelectronics.stm32cube-ide-registers
      stmicroelectronics.stm32cube-ide-project-manager
      stmicroelectronics.stm32-vscode-extension
      stmicroelectronics.stm32cube-ide-build-cmake
      stmicroelectronics.stm32cube-ide-clangd
      stmicroelectronics.stm32cube-ide-build-analyzer
      stmicroelectronics.stm32cube-ide-bundles-manager
      stmicroelectronics.stm32cube-ide-debug-core
      stmicroelectronics.stm32cube-ide-debug-generic-gdbserver
      stmicroelectronics.stm32cube-ide-debug-stlink-gdbserver
      stmicroelectronics.stm32cube-ide-debug-jlink-gdbserver
      # Nix extension
      bbenoist.nix
      # CPP Include Guard extension
      akiramiyakoda.cppincludeguard
      # Theme
      enkia.tokyo-night

    ]);

    profiles.default.userSettings = {
      # General settings
      "telemetry.telemetryLevel" = "off";
      "workbench.startupEditor" = "none";
      "workbench.colorTheme" = "Tokyo Night";

      # cppincludeguard extension
      "C/C++ Include Guard.Prefix" = "_";
      "C/C++ Include Guard.Suffix" = "_H_";
      
      # vim extension
      "vim.useSystemClipboard" = true;
      "vim.leader" = "<space>";
      "vim.normalModeKeyBindingsNonRecursive" = [
        { before = ["<C-a>"]; after = ["g" "g" "V" "G"]; }
        { before = ["Y"]; after = ["y" "$"]; }
        { before = ["d"]; after = ["\"" "_" "d"]; }
        { before = ["D"]; after = ["\"" "_" "D"]; }
        { before = ["x"]; after = ["\"" "_" "x"]; }
        { before = ["X"]; after = ["\"" "_" "X"]; }
        { before = ["c"]; after = ["\"" "_" "c"]; }
        { before = ["C"]; after = ["\"" "_" "C"]; }
        { before = ["s"]; after = ["\"" "_" "s"]; }
        { before = ["J"]; after = ["m" "z" "J" "`" "z"]; }
        { before = ["<C-j>"]; after = ["<C-d>" "z" "z"]; }
        { before = ["<C-k>"]; after = ["<C-u>" "z" "z"]; }
        { before = ["<leader>" "d"]; after = ["\"" "_" "d"]; }
        { before = ["<leader>" "<Left>"];  commands = ["workbench.action.focusLeftGroup"]; }
        { before = ["<leader>" "<Down>"];  commands = ["workbench.action.focusBelowGroup"]; }
        { before = ["<leader>" "<Up>"];    commands = ["workbench.action.focusAboveGroup"]; }
        { before = ["<leader>" "<Right>"]; commands = ["workbench.action.focusRightGroup"]; }
        { before = ["<leader>" "s" "v"]; commands = ["workbench.action.splitEditorRight"]; }
        { before = ["<leader>" "s" "h"]; commands = ["workbench.action.splitEditorDown"]; }
        { before = ["<A-j>"]; commands = ["editor.action.moveLinesDownAction"]; }
        { before = ["<A-k>"]; commands = ["editor.action.moveLinesUpAction"]; }
        { before = ["<leader>" "e"];       commands = ["workbench.view.explorer"]; }
        { before = ["<leader>" "f" "f"];   commands = ["workbench.action.quickOpen"]; }
        { before = ["<leader>" "p" "a"];   commands = ["copyFilePath"]; }
      ];
      "vim.visualModeKeyBindingsNonRecursive" = [
        { before = ["<C-a>"]; after = ["<Esc>" "g" "g" "V" "G"]; }
        { before = ["<A-j>"]; commands = ["editor.action.moveLinesDownAction"]; }
        { before = ["<A-k>"]; commands = ["editor.action.moveLinesUpAction"]; }
        { before = ["<leader>" "d"]; after = ["\"" "_" "d"]; }
        { before = ["<leader>" "p"]; after = ["\"" "_" "d" "P"]; }
      ];
      "vim.insertModeKeyBindings" = [
        { before = ["<C-a>"]; after = ["<Esc>" "g" "g" "V" "G"]; }
        { before = ["<C-p>"]; after = ["<C-r>" "+"]; }
      ];

    };
  };


  home.activation.vscodeMutableSettings = lib.hm.dag.entryAfter ["writeBoundary"] ''
    target="$HOME/.config/Code/User/settings.json"
    if [ -L "$target" ]; then
      real=$(readlink -f "$target")
      rm "$target"
      cp "$real" "$target"
      chmod u+w "$target"
    fi
  '';  
}
