
# Jflocke's NixOS Flake Configuration: Productivity & Ricing

Hey! This is my personal NixOS configuration. It's a living document and setup, tailored for my workflow, devices, and taste. While you might find inspiration or orientation here, it's not meant to be a drop-in template for others—expect quirks, experiments, and lots of ricing!


## Table of Contents
- Features
- Repository Structure
- Getting Started
- Multi-Device & Multi-User
- Productivity Stack
- Ricing & Aesthetics
- Dev Environments
- Home Manager & Dotfiles
- Contributing
- References

---

## Features
- **Nix Flakes** for reproducible, declarative system configuration
- **Multi-device** support (laptops, desktops, VMs)
- **Multi-user** setup with home-manager
- **Declarative dotfiles** for every user
- **Multiple DEs & WMs**: Gnome, Plasma 6, Hyprland, Qtile, bspwm, and more
- **Productive terminal**: Fish shell + Starship prompt, custom tweaks
- **Neovim**: Modern, extensible editor setup
- **DevShells**: Per-user, per-project environments using [devenv](https://devenv.sh)
- **Aesthetic (riced) system**: Beautiful themes, fonts, and UI tweaks


## Repository Structure
```
hosts/
	yoga/        # Device-specific configs
	vm/
	desktop/
	ideapad/
modules/
	users/
		jflocke/   # My home-manager config and dotfiles
		kschmidt/
	core/        # Shared modules (fonts, themes, etc.)
pkgs/          # Custom packages I build from source
wallpapers/    # My favorite backgrounds and ricing assets
flake.nix      # Entry point for Nix flakes
hardware-configuration.nix # to be moved into each host
README.md
CHANGELOG.md
TODO.md
```

## Multi-Device & Multi-User
- Each device has its own config in `hosts/<device>/configuration.nix`.
- Users are managed via `modules/users/<username>/home.nix` using home-manager.
- Add new devices/users by creating new folders/files and referencing them in `flake.nix`.

## Productivity Stack
- **Terminal**: Fish shell with Starship prompt, custom aliases, functions, and completions for speed and ergonomics.
- **Neovim**: Fully configured with plugins for coding, writing, and ricing (themes, icons, LSP, etc.).
- **DevShells**: Use [devenv](https://devenv.sh) to create reproducible environments for Bevy, Svelte, and other stacks. Each user can have their own devshells.
- **System Tweaks**: Fast keybindings, clipboard integration, notification management, and more.

## Ricing & Aesthetics
- **DEs & WMs**: Easily switch between Gnome, Plasma 6, Hyprland, Qtile, bspwm, etc.
- **Themes**: GTK, Qt, and WM themes, custom wallpapers, icon packs, and fonts.
- **Terminal Ricing**: Beautiful prompt, color schemes, and transparency.
- **Neovim Ricing**: Custom colorschemes, statusline, icons, and UI tweaks.
- **Lockscreen, Login, and Boot**: Custom plymouth, SDDM/GDM themes.

## Dev Environments
- **devenv**: Define per-user, per-project devshells in `modules/users/<username>/devshells.nix`.
- **Supported stacks**: Bevy (Rust game engine), Svelte (JS framework), and more.
- **Automatic setup**: Enter a project folder and run `nix develop` for instant environment.

## Home Manager & Dotfiles
- **Declarative dotfiles**: Every config (fish, neovim, git, etc.) is managed via home-manager.
- **Portable**: Move your setup to any device by switching host/user configs.


## Contributing
This is mostly for my own use, but if you have ideas, want to chat about NixOS, or spot something, feel free to open an issue or PR. See `CHANGELOG.md` for my latest tweaks.

## References
- [NixOS Wiki](https://nixos.wiki/)
- [Home Manager](https://nix-community.github.io/home-manager/)
- [devenv](https://devenv.sh)
- [Fish Shell](https://fishshell.com/)
- [Starship Prompt](https://starship.rs/)
- [Neovim](https://neovim.io/)

---

**Enjoy your productive and beautiful NixOS system!**
