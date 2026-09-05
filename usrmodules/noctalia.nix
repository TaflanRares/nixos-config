{ inputs, ... }:

{
	imports = [ inputs.noctalia.homeModules.default ];

	programs.noctalia = {
		enable = true;

		settings = {
      
      plugins = {
        enabled = [ "noctalia/mpvpaper" ];
      };

			bar.default = {
				position              = "top";
				thickness             = 22;
				margin_ends           = 0;
				margin_edge           = 0; 
				margin_opposite_edge  = 0;
				padding               = 8;
				widget_spacing        = 4;
				radius                = 0;
				background_opacity    = 1.0; 
				capsule               = false;

				start  = [ "launcher" "workspaces" ];
				center = [ "clock" ];
				end    = [ "tray" "volume" "battery" "control-center" ];
			};

			theme = {
				source         = "custom";
				custom_palette = "AllBlack";
			};
		};
	};

	home.file.".config/noctalia/palettes/AllBlack.json".text = builtins.toJSON {
		dark = {
			mPrimary          = "#e5e5e5";
			mOnPrimary        = "#000000";
			mSecondary        = "#999999";
			mOnSecondary      = "#000000";
			mTertiary         = "#666666";
			mOnTertiary       = "#000000";
			mError            = "#ff4444";
			mOnError          = "#000000";
			mSurface          = "#000000";
			mOnSurface        = "#e5e5e5";
			mSurfaceVariant   = "#0a0a0a";
			mOnSurfaceVariant = "#8a8a8a";
			mOutline          = "#1f1f1f";
			mShadow           = "#000000";
			mHover            = "#141414";
			mOnHover          = "#ffffff";
			terminal = {
				background  = "#000000";
				foreground  = "#e5e5e5";
				cursor      = "#ffffff";
				cursorText  = "#000000";
				selectionBg = "#e5e5e5";
				selectionFg = "#000000";
				normal = {
					black = "#000000"; red = "#8a8a8a"; green = "#8a8a8a"; yellow = "#8a8a8a";
					blue  = "#8a8a8a"; magenta = "#8a8a8a"; cyan = "#8a8a8a"; white = "#e5e5e5";
				};
				bright = {
					black = "#333333"; red = "#c0c0c0"; green = "#c0c0c0"; yellow = "#c0c0c0";
					blue  = "#c0c0c0"; magenta = "#c0c0c0"; cyan = "#c0c0c0"; white = "#ffffff";
				};
			};
		};
	};
}
