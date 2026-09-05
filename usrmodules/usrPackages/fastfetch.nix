{ config, pkgs, ... }:

let
  greenPrimary = "9ECE9A";
  greenDark    = "74A57f";
  greenJungle  = "3DAC73";
  greenSea     = "10926D";

  cBorder  = "{##${greenJungle}}";
  cSysInfo = "{##${greenDark}}";
  cDesktop = "{##${greenSea}}";
  cHardware= "{##${greenPrimary}}";
  cIcons   = "{##${greenSea}}";
  cReset   = "{#}";
in
{
  programs.fastfetch = {
    enable = true;

    settings = {
      "$schema" =
        "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";

      logo = {
        type = "data";
        color = {
          "1" = "38;2;158;206;154";
          "2" = "38;2;100;100;100"; 
        };
        source = ''
                                                     ___
                                                  ,o88888
                                               ,o8888888'
                         ,:o:o:oooo.        ,8O88Pd8888"
                     ,.::.::o:ooooOoOoO. ,oO8O8Pd888'"
                   ,.:.::o:ooOoOoOO8O8OOo.8OOPd8O8O"
                  , ..:.::o:ooOoOOOO8OOOOo.FdO8O8"
                 , ..:.::o:ooOoOO8O888O8O,COCOO"
                , . ..:.::o:ooOoOOOO8OOOOCOCO"
                 . ..:.::o:ooOoOoOO8O8OCCCC"o
                    . ..:.::o:ooooOoCoCCC"o:o
                    . ..:.::o:o:,cooooCo"oo:o:
                 `   . . ..:.:cocoooo"'o:o:::'
                 .`   . ..::ccccoc"'o:o:o:::'
                :.:.    ,c:cccc"':.:.:.:.:.'
              ..:.:"'`::::c:"'..:.:.:.:.:.'
            ...:.'.:.::::"'    . . . . .'
           .. . ....:."' `   .  . . '
         . . . ...."'
         .. . ."' 
        .
        '';

        padding = {
          top = 1;
          left = 1;
          right = 1;
        };
      };

      display = {
        separator = " ";

        color = {
          keys = "38;2;228;197;175;";
          title = "38;61;172;115;";
          output = "white";
          separator = "green";
        };

        key = {
          width = 18;
          type = "string";
        };
      };

      modules = [
        # Header
        /*
        {
          type = "title";
          format = "${cBorder}╭─ ${cReset}{user-name-colored}${cBorder}@${cHardware}{host-name} ";
        }
        "break"
        */
        # System Information
        {
          type = "custom";
          format = "${cBorder}╭──── ${cSysInfo}SY${cBorder} ────╮${cReset}";
        }
        {
          type = "os";
          key = "${cBorder}│ ${cSysInfo}󰍹 OS       ${cBorder}│${cReset}";
          format = "{pretty-name}";
        }
        {
          type = "kernel";
          key = "${cBorder}│ ${cSysInfo}󰒋 Kernel   ${cBorder}│${cReset}";
          format = "{release}";
        }
        {
          type = "uptime";
          key = "${cBorder}│ ${cSysInfo}󰅐 Uptime   ${cBorder}│${cReset}";
        }
        {
          type = "packages";
          key = "${cBorder}│ ${cSysInfo}󰏖 Packages ${cBorder}│${cReset}";
          format = "{all}";
        }
        {
          type = "custom";
          format = "${cBorder}╰────────────╯${cReset}";
        }

        "break"

        # Desktop Environment
        {
          type = "custom";
          format = "${cBorder}╭──── ${cDesktop}DE${cBorder} ────╮${cReset}";
        }
        {
          type = "de";
          key = "${cBorder}│ ${cIcons}󰧨 DE       ${cBorder}│${cReset}";
          format = "{pretty-name}";
        }
        {
          type = "wm";
          key = "${cBorder}│ ${cIcons}󱂬 WM       ${cBorder}│${cReset}";
          format = "{pretty-name}";
        }
        {
          type = "wmtheme";
          key = "${cBorder}│ ${cIcons}󰉼 Theme    ${cBorder}│${cReset}";
        }
        {
          type = "monitor";
          key = "${cBorder}│ ${cIcons}󰹑 Display  ${cBorder}│${cReset}";
          format = "{width}x{height} @ {refresh-rate}Hz";
        }
        {
          type = "shell";
          key = "${cBorder}│ ${cIcons}󰞷 Shell    ${cBorder}│${cReset}";
          format = "{pretty-name}";
        }
        {
          type = "terminal";
          key = "${cBorder}│ ${cIcons}󰞍 Terminal ${cBorder}│${cReset}";
          format = "{pretty-name}";
        }
        {
          type = "terminalfont";
          key = "${cBorder}│ ${cIcons}󰛖 Font     ${cBorder}│${cReset}";
        }
        {
          type = "custom";
          format = "${cBorder}╰────────────╯${cReset}";
        }

        "break"

        # Hardware Information
        {
          type = "custom";
          format = "${cBorder}╭──── ${cHardware}HW${cBorder} ────╮${cReset}";
        }
        {
          type = "cpu";
          key = "${cBorder}│ ${cHardware}󰻠 CPU    ${cBorder}  │${cReset}";
          format = "{1}";
        }
        {
          type = "gpu";
          key = "${cBorder}│ ${cHardware}󰢮 GPU    ${cBorder}  │${cReset}";
          format = "{name}";
        }
        {
          type = "memory";
          key = "${cBorder}│ ${cHardware}󰍛 Memory ${cBorder}  │${cReset}";
        }
        {
          type = "disk";
          key = "${cBorder}│ ${cHardware}󰋊 Root   ${cBorder}  │${cReset}";
          folders = "/";
          stat = "fast";
          format = "{size-used} / {size-total} ({size-percentage})";
        }
        {
          type = "disk";
          key = "${cBorder}│ ${cHardware}󰋊 Home   ${cBorder}  │${cReset}";
          folders = "/home";
          stat = "fast";
          format = "{size-used} / {size-total} ({size-percentage})";
        }
        {
          type = "custom";
          format = "${cBorder}╰────────────╯${cReset}";
        }

        "break"

        # Colors
        /*
        {
          type = "colors";
          key = "${cBorder}  ";
          symbol = "circle";
          paddingLeft = 4;
        }
        */
      ];
    };
  };
}
