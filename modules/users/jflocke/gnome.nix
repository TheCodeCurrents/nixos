{ config, pkgs, ... }:

let
  # Use Catppuccin colors instead of custom palette
  catppuccinPalette = [
    "#45475A" "#F38BA8" "#A6E3A1" "#F9E2AF"
    "#89B4FA" "#F5C2E7" "#94E2D5" "#BAC2DE"
    "#585B70" "#F38BA8" "#A6E3A1" "#F9E2AF"
    "#89B4FA" "#F5C2E7" "#94E2D5" "#A6ADC8"
  ];
in {
  # Enable catppuccin
  catppuccin.enable = true;
  catppuccin.flavor = "mocha";

  home.packages = with pkgs; [
    gnome-tweaks
    gnomeExtensions.vitals
    gnomeExtensions.user-themes
    papirus-icon-theme
    # Add Catppuccin GTK theme
    catppuccin-gtk
  ];

  # Enable catppuccin for GTK
  # catppuccin.gtk.enable = true;

  dconf.settings = {
    # GTK Theme - will be set by catppuccin
    "org/gnome/desktop/interface" = {
      gtk-theme = "catppuccin-mocha-mauve-standard";
      icon-theme = "Papirus-Dark";
      color-scheme = "prefer-dark";
    };

    # Shell theme (requires User Themes extension)
    "org/gnome/shell/extensions/user-theme" = {
      name = "catppuccin-mocha-mauve-standard";
    };

    "org/gnome/shell/extensions/vitals" = {
      show-memory = true;
      show-cpu = true;
      show-temperature = true;
      show-storage = false;
      show-network = false;
    };

    # Terminal color scheme (Catppuccin Mocha)
    "org/gnome/terminal/legacy/profiles:/:<PROFILE_ID>" = {
      visible-name = "Catppuccin Mocha";
      use-theme-colors = false;
      background-color = "'#1E1E2E'";
      foreground-color = "'#CDD6F4'";
      palette = catppuccinPalette;
    };

    "org/gnome/desktop/wm/keybindings" = {
      switch-applications = ["<Super>Tab"];
      switch-applications-backward = ["<Shift><Super>Tab"];
      switch-group = ["<Alt>Tab"];
      switch-group-backward = ["<Shift><Alt>Tab"];
      switch-to-workspace-1 = ["<Super>1"];
      switch-to-workspace-2 = ["<Super>2"];
      switch-to-workspace-3 = ["<Super>3"];
      switch-to-workspace-4 = ["<Super>4"];
      move-to-workspace-1 = ["<Shift><Super>1"];
      move-to-workspace-2 = ["<Shift><Super>2"];
      move-to-workspace-3 = ["<Shift><Super>3"];
      move-to-workspace-4 = ["<Shift><Super>4"];
    };

    # Enable extensions
    "org/gnome/shell" = {
      enabled-extensions = [
        "Vitals@CoreCoding.com"
        "user-theme@gnome-shell-extensions.gcampax.github.com"
      ];
    };
  };
}