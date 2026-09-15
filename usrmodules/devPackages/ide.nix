{ config, pkgs, inputs, ... }:

let
  vscodeMarketplaceExtensions = inputs.nix-vscode-extensions.extensions.${pkgs.stdenv.hostPlatform.system};
  stm32cubemxWrapped = pkgs.writeShellScriptBin "stm32cubemx-wrapped" ''
    set -eu

    export XDG_CONFIG_HOME="''${XDG_CONFIG_HOME:-$HOME/.config}"
    export XDG_CACHE_HOME="''${XDG_CACHE_HOME:-$HOME/.cache}"
    export XDG_DATA_HOME="''${XDG_DATA_HOME:-$HOME/.local/share}"

    export STM32CUBEMX_USER_DATA="$XDG_DATA_HOME/STM32CubeMX"

    project_hint="$PWD"
    for arg in "$@"; do
      case "$arg" in
        *.ioc)
          project_hint="$(dirname "$arg")"
          break
          ;;
      esac
    done

    workspace_id="$(printf '%s' "$project_hint" | sha256sum | cut -c1-16)"
    export STM32CUBEMX_WORKSPACE="$XDG_DATA_HOME/STM32CubeMX/workspaces/$workspace_id"

    mkdir -p \
      "$STM32CUBEMX_USER_DATA" \
      "$STM32CUBEMX_WORKSPACE" \
      "$XDG_CACHE_HOME/stm32cubemx" \
      "$XDG_CACHE_HOME/tmp" \
      "$HOME/.stm32cubemx/thirdparties/db"

    updater_xml="$HOME/.stm32cubemx/thirdparties/db/updaterThirdParties.xml"
    if [ ! -e "$updater_xml" ]; then
      cp ${pkgs.stm32cubemx}/opt/STM32CubeMX/db/plugins/updater/updaterThirdParties.xml "$updater_xml"
      chmod u+w "$updater_xml"
    fi

    export JAVA_TOOL_OPTIONS="''${JAVA_TOOL_OPTIONS-} -Duser.home=$HOME -Djava.io.tmpdir=$XDG_CACHE_HOME/tmp"

    exec ${pkgs.stm32cubemx}/bin/stm32cubemx "$@"
  '';
in
{
  programs.vscode = {
    enable = true;
    mutableExtensionsDir = false;

    profiles.default.extensions = with pkgs.vscode-extensions; [
      ms-vscode.cpptools-extension-pack
      marus25.cortex-debug
      vscodevim.vim
      yzhang.markdown-all-in-one
      sumneko.lua
    ] ++ (with vscodeMarketplaceExtensions.vscode-marketplace; [
      # Nix extension
      bbenoist.nix
      # STM32CubeIDE extensions
      eclipse-cdt.memory-inspector
      eclipse-cdt.serial-monitor
      mcu-debug.debug-tracker-vscode
      mcu-debug.memory-view
      mcu-debug.rtos-views
      mcu-debug.peripheral-viewer
      ms-vscode.cmake-tools
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
      # Cpp Include Guard extension
      akiramiyakoda.cppincludeguard
    ]);

    profiles.default.userSettings = {
      "telemetry.telemetryLevel" = "off";
      "workbench.startupEditor" = "none";
      "workbench.colorTheme" = "Dark Modern";

      "stm32cube-ide-core.configuration.productSTM32CubeMX.executablePath" = "${stm32cubemxWrapped}/bin/stm32cubemx-wrapped";
      "C_Cpp.default.compilerPath" = "${pkgs.gcc-arm-embedded}/bin/arm-none-eabi-gcc";
      "cortex-debug.armToolchainPath" = "${pkgs.gcc-arm-embedded}/bin";
      "cortex-debug.openocdPath" = "${pkgs.openocd}/bin/openocd";
      "cmake.environment" = {
        "PATH" = "${vscodeMarketplaceExtensions.vscode-marketplace.stmicroelectronics.stm32cube-ide-build-cmake}/share/vscode/extensions/stmicroelectronics.stm32cube-ide-build-cmake/resources/cube-cmake/linux/x86_64:${vscodeMarketplaceExtensions.vscode-marketplace.stmicroelectronics.stm32cube-ide-core}/share/vscode/extensions/stmicroelectronics.stm32cube-ide-core/resources/binaries/linux/x86_64:\${env.PATH}";
      };
      "stm32cube-ide-build-cmake.intellisense.enableAutomaticConfiguration" = false;
      "stm32cube-ide-build-cmake.ignoreCubeProjectDiscovery" = true;
      "stm32cube-ide-build-cmake.project-setup.incubationWebview" = false;
      "stm32cube-ide-core.enableTelemetry" = false;
      "stm32cube-ide-core.synchronizePdscRepositoriesOnStartup" = false;

      "C/C++ Include Guard.Prefix" = "_";
      "C/C++ Include Guard.Suffix" = "_H_";
      
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
}