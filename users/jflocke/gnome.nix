{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    gnome-tweaks
    gnomeExtensions.vitals
    gnomeExtensions.blur-my-shell
    # gnomeExtensions.user-themes
  ];

  dconf.settings = {
    "org/gnome/desktop/background" = {
      picture-uri = "file:///home/jflocke/nixos/wallpapers/jellyfish.jpg";
      picture-uri-dark = "file:///home/jflocke/nixos/wallpapers/jellyfish.jpg";
      picture-options = "zoom";
    };

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };

    "org/gnome/desktop/screensaver" = {
      picture-uri = "file:///home/jflocke/nixos/wallpapers/jellyfish.jpg";
    };

    "org/gnome/shell/extensions/vitals" = {
      show-memory = true;
      show-cpu = true;
      show-temperature = true;
      show-storage = true;
      show-network = true;
      show-gpu = true;
    };

    "org/gnome/shell/extensions/blur-my-shell" = {
      show-memory = true;
      show-cpu = true;
      show-temperature = true;
      show-storage = true;
      show-network = true;
      show-gpu = true;
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

    "org/gnome/shell" = {
      enabled-extensions = [
        "Vitals@CoreCoding.com"
        "blur-my-shell@aunetx"
      ];
    };
  };
}
