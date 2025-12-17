
# NixOS Flake (jflocke)

Personal NixOS + Home Manager setup for my machines. Trimmed to the pieces I actually use.

## What this repo does
- Flake-driven NixOS for three hosts: `ideapad`, `yoga`, `onyx`.
- Home Manager for user `jflocke` (fish + starship, nixvim, GNOME tweaks, MangoWM, git).
- Optional modules you can mix per host: gaming (Steam/Lutris/wine), Docker, virtualization (libvirtd), Syncthing, Ollama (CUDA), Wayland WMs (niri + mango).
- GNOME as the default desktop, with Wayland-first env vars and xdg-desktop-portal-wlr.
- Fonts, Flatpak/AppImage, nix-ld, and common desktop utilities preinstalled.

## Layout
```
flake.nix                     # Entrypoint
hosts/
	ideapad/ configuration.nix  # AMD laptop
	yoga/    configuration.nix  # Intel + NVIDIA Prime laptop
	onyx/    configuration.nix  # NVIDIA desktop
modules/
	common.nix                  # Base system defaults (boot, GNOME, audio, fonts, core pkgs)
	docker.nix                  # Docker + group + tools
	gaming.nix                  # Steam/Lutris/wine + firewall holes
	syncthing.nix               # Per-host devices/folders
	virtualization.nix          # libvirtd + virt-manager
	wayland-wm.nix              # niri + mango + Wayland utils
	ollama.nix                  # Ollama with CUDA
users/jflocke/
	home.nix                    # Home Manager entry, imports below
	terminal.nix                # fish, starship, zoxide, fzf, eza, zellij
	gnome.nix                   # dconf tweaks, extensions, wallpaper
	mango.nix                   # MangoWM settings
	nixvim.nix                  # nixvim plugins/LSPs/theme
	git.nix, fpga.nix
	niri/config.kdl             # minimal niri config
wallpapers/                   # backgrounds used in configs
```

## How hosts are built
Each host imports `modules/common.nix` plus the optional modules it needs:
- `ideapad`: base + gaming + virtualization + docker + syncthing + wayland-wm
- `yoga`: base + gaming + virtualization + docker + syncthing + wayland-wm
- `onyx`: base + gaming + virtualization + docker + syncthing + wayland-wm + ollama

Tweak per-host imports in `hosts/<name>/configuration.nix` to slim or expand.

## Home Manager highlights
- fish + starship with catppuccin
- nixvim with treesitter, LSPs, DAP, telescope, cmp
- GNOME extensions (Vitals, Blur My Shell, User Themes) and shortcuts
- MangoWM session bits (waybar, swaybg, clipboard) + Wayland tooling
- VS Code FHS build with dev deps; editor packages (zed, typst, rust/zig/node)

## Notes
- Ollama is isolated to `modules/ollama.nix`; only `onyx` imports it. Add it to other hosts if you want GPU LLMs.
- Syncthing device map is host-aware; adjust IDs in `modules/syncthing.nix` if hardware changes.
- `users/jflocke/niri/config.kdl` is minimal—extend as needed.
