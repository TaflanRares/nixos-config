# ❄️ NixOS Config

My personal NixOS configuration, built with **Nix Flakes** and **Home Manager**.

![NixOS](https://img.shields.io/badge/NixOS-5277C3?style=flat-square&logo=nixos&logoColor=white)
![Noctalia](https://img.shields.io/badge/Noctalia-a370f7?style=flat-square&logo=wayland&logoColor=white)
![Hyprland](https://img.shields.io/badge/WM-Hyprland-89b4fa?style=flat-square)
![Fish](https://img.shields.io/badge/Shell-Fish-blue?style=flat-square)

## Structure

```
.
├── config/          # Symlinked standalone config files
│ ├── hypr-config/   # Hyprland configuration
│ └── nvim-config/   # Neovim configuration
├── sysmodules/      # Core system-level modules
└── usrmodules/      # User-level modules
├── devPackages/     # Development & programming packages
└── usrPackages/     # General user applications
```

⚠️ This config is tailored to my hardware/setup
