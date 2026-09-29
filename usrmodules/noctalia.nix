{ inputs, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia = {
    enable = true;

    settings = {

      # Plugins
      plugins = {
        enabled = [
          "noctalia/mpvpaper"
        ];
      };

      plugin_settings."noctalia/mpvpaper" = {
        video_directory = "/home/rares/Pictures/Wallpapers/animatedWallpapers";
      };

      # Accessibility
      accessibility = {
        ui_scale = 1.05;
      };

      # Bar
      bar.default = {
        position = "top";
        thickness = 22;
        margin_ends = 0;
        margin_edge = 0;
        margin_opposite_edge = 0;
        padding = 8;
        widget_spacing = 4;
        radius = 0;
        background_opacity = 1.0;
        capsule = false;

        start = [
          "mpvpaper"
          "left_side_spacer"
          "tray"
          "left_spacer"
          "workspaces"
        ];

        center = [
          "clock"
        ];

        end = [
          "group:g1"
          "right_spacer"
          "ram"
          "right_spacer_2"
          "battery"
          "right_side_spacer"
        ];

        capsule_group = [
          {
            id = "g1";
            enabled = true;
            accordion = false;
            accordion_direction = "end";
            fill = "surface_variant";
            members = [
              "audio_visualizer"
              "volume"
            ];
            opacity = 0.25;
            padding = 6;
          }
        ];
      };

      # Control Center
      control_center = {
        hidden_tabs = [
          "media"
          "screen-time"
        ];

        calendar = {
          show_events_card = false;
        };

        shortcuts = [
          { type = "wifi"; }
          { type = "bluetooth"; }
          { type = "notification"; }
          { type = "mic_mute"; }
          { type = "clipboard"; }
          { type = "keyboard_layout"; }
        ];
      };

      # Power profile Hooks
      hooks = {
        battery_charging = "powerprofilesctl set balanced";
        battery_plugged = "powerprofilesctl set balanced";
        battery_discharging = "powerprofilesctl set power-saver";
      };

      # Idle
      idle = {
        behavior_order = [
          "lock"
          "screen-off"
          "lock-and-suspend"
        ];

        behavior.lock = {
          action = "lock";
          enabled = true;
          timeout = 900;
        };

        behavior.screen-off = {
          action = "screen_off";
          enabled = true;
          timeout = 300;
        };

        behavior.lock-and-suspend = {
          action = "lock_and_suspend";
          enabled = true;
          timeout = 1800;
        };
      };

      # Lockscreen
      lockscreen = {
        blur_intensity = 0.45;
        fingerprint = false;
      };

      lockscreen_widgets = {
        enabled = false;
        schema_version = 2;
        widget_order = [
          "lockscreen-login-box@eDP-1"
        ];

        grid = {
          cell_size = 16;
          major_interval = 4;
          visible = true;
        };

        widget."lockscreen-login-box@eDP-1" = {
          box_height = 196;
          box_width = 810;
          cx = 960;
          cy = 898;
          output = "eDP-1";
          placement_height = 1080;
          placement_width = 1920;
          rotation = 0;
          type = "login_box";

          settings = {
            background_color = "surface_variant";
            background_opacity = 0.88;
            background_radius = 12;
            center_password_text = false;
            input_opacity = 1.0;
            input_radius = 6;
            layout = "regular";
            show_caps_lock = true;
            show_keyboard_layout = true;
            show_login_button = true;
            show_media = true;
            show_session_buttons = true;
            show_unlock_hint = true;
            show_weather = true;
          };
        };
      };

      # Shell
      shell = {
        avatar_path = "/home/rares/Pictures/Fastfetch/KlimtGarden.jpg";

        corner_radius_scale = 0.0;

        font_family = "JetBrainsMono Nerd Font Mono";

        polkit_agent = true;

        settings_window_translucent = true;

        animation = {
          speed = 1.5;
        };

        greeter_sync = {
          auto_sync = true;
        };

        launcher = {
          compact = true;

          pinned = [
            "zen-beta"
            "steam"
            "kitty"
          ];
        };

        panel = {
          clipboard_placement = "attached";
          open_near_click_clipboard = true;
          transparency_mode = "soft";
        };

        screenshot = {
          directory = "/home/rares/Pictures/screenshots";
        };

        session.actions = [
          {
            action = "lock";
            countdown_seconds = 0;
            enabled = true;
            shortcut = "1";
            variant = "default";
          }

          {
            action = "logout";
            countdown_seconds = 0;
            enabled = false;
            shortcut = "2";
            variant = "default";
          }

          {
            action = "lock_and_suspend";
            countdown_seconds = 0;
            enabled = true;
            shortcut = "3";
            variant = "default";
          }

          {
            action = "reboot";
            countdown_seconds = 0;
            enabled = true;
            shortcut = "4";
            variant = "default";
          }

          {
            action = "shutdown";
            countdown_seconds = 0;
            enabled = true;
            shortcut = "5";
            variant = "destructive";
          }
        ];
      };

      # Theme
      theme = {
        source = "community";
        community_palette = "Vesper";
        custom_palette = "AllBlack";
        builtin = "Catppuccin";
        mode = "dark";
        wallpaper_scheme = "m3-content";
      };

      # Widgets
      widget.active_window = {
        display = "icon_only";
        icon_color = "secondary";
        icon_size = 18;
        max_length = 40;
        min_length = 0;
        show_empty_label = true;
      };

      widget.audio_visualizer = {
        bands = 10;
        color_2 = "secondary";
        width = 50;

        actions.left = "panel-toggle control-center audio";
      };

      widget.clock.actions.left =
        "panel-toggle control-center home";

      widget.left_side_spacer = {
        length = 10;
        type = "spacer";
      };

      widget.left_spacer = {
        length = 10;
        type = "spacer";
      };

      widget.mpvpaper = {
        type = "noctalia/mpvpaper:mpvpaper";
      };

      widget.ram = {
        stat = "ram_pct";
        visualization = "none";
      };

      widget.right_side_spacer = {
        length = 10;
        type = "spacer";
      };

      widget.right_spacer = {
        length = 8;
        type = "spacer";
      };

      widget.right_spacer_2 = {
        length = 11;
        type = "spacer";
      };

      widget.tray = {
        drawer = true;
      };
    };
  };


  # AllBlack
  home.file.".config/noctalia/palettes/AllBlack.json".text =
    builtins.toJSON {
      dark = {
        mPrimary = "#e5e5e5";
        mOnPrimary = "#000000";
        mSecondary = "#999999";
        mOnSecondary = "#000000";
        mTertiary = "#666666";
        mOnTertiary = "#000000";
        mError = "#ff4444";
        mOnError = "#000000";
        mSurface = "#000000";
        mOnSurface = "#e5e5e5";
        mSurfaceVariant = "#0a0a0a";
        mOnSurfaceVariant = "#8a8a8a";
        mOutline = "#1f1f1f";
        mShadow = "#000000";
        mHover = "#141414";
        mOnHover = "#ffffff";

        terminal = {
          background = "#000000";
          foreground = "#e5e5e5";
          cursor = "#ffffff";
          cursorText = "#000000";
          selectionBg = "#e5e5e5";
          selectionFg = "#000000";

          normal = {
            black = "#000000";
            red = "#8a8a8a";
            green = "#8a8a8a";
            yellow = "#8a8a8a";
            blue = "#8a8a8a";
            magenta = "#8a8a8a";
            cyan = "#8a8a8a";
            white = "#e5e5e5";
          };

          bright = {
            black = "#333333";
            red = "#c0c0c0";
            green = "#c0c0c0";
            yellow = "#c0c0c0";
            blue = "#c0c0c0";
            magenta = "#c0c0c0";
            cyan = "#c0c0c0";
            white = "#ffffff";
          };
        };
      };
    };
}
