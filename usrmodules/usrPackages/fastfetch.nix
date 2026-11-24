{ ... }:

{
  programs.fastfetch = {
    enable = true;

    settings = {
      "$schema" =
        "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";

      logo = {
        type = "data";
        source = builtins.readFile ../../config/fastfetch1.txt;

        padding = {
          top = 0;
          left = 1;
          right = 1;
        };
      };

      display = {
        separator = "  ";

        color = {
          keys = "38;2;255;85;85";
          output = "38;2;255;255;255";
          separator = "38;2;170;170;170";
        };

        key = {
          width = 12;
          type = "string";
        };
      };

      modules = [
        # Offset info down so it appears centered relative to tall logo.
        "break"
        "break"
        "break"
        "break"
        "break"
        "break"
        "break"
        "break"
        "break"
        "break"
        "break"
        "break"

        {
          type = "os";
          key = "OS";
          format = "{pretty-name}";
        }
        {
          type = "host";
          key = "Host";
        }
        {
          type = "kernel";
          key = "Kernel";
          format = "{release}";
        }
        {
          type = "uptime";
          key = "Uptime";
        }
        "break"
        {
          type = "de";
          key = "DE";
          format = "{pretty-name}";
        }
        {
          type = "wm";
          key = "WM";
          format = "{pretty-name}";
        }
        {
          type = "shell";
          key = "Shell";
          format = "{pretty-name}";
        }
        {
          type = "terminal";
          key = "Terminal";
          format = "{pretty-name}";
        }
        "brake"
        {
          type = "cpu";
          key = "CPU";
          format = "{1}";
        }
        {
          type = "memory";
          key = "Memory";
        }
        {
          type = "disk";
          key = "Root";
          folders = "/";
          stat = "fast";
          format = "{size-used} / {size-total} ({size-percentage})";
        }
        {
          type = "disk";
          key = "Home";
          folders = "/home";
          stat = "fast";
          format = "{size-used} / {size-total} ({size-percentage})";
        }
        "break"
        {
          type = "colors";
          key = "  ";
          symbol = "circle";
        }
      ];
    };
  };
}
