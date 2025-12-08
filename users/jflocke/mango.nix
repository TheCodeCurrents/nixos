{ config, pkgs, ... }:

{
  ########################
  ## Mango via HM module
  ########################

  wayland.windowManager.mango = {
    enable = true;

    # This is Mango's config language (same as ~/.config/mango/config.conf)
    # Start simple, then extend using the wiki/docs.
    # https://github.com/DreamMaoMao/mangowc/wiki :contentReference[oaicite:2]{index=2}
    settings = ''
      ##### Environment #####
      env=MOZ_ENABLE_WAYLAND,1
      env=XCURSOR_SIZE,24
      shell=/run/current-system/sw/bin/bash

      ##### Basic behaviour #####
      # use SUPER as the main modifier
      mod=SUPER

      ##### Applications #####
      # terminal
      bind=SUPER,Return,exec,foot

      # launcher (change to rofi/fuzzel/wmenu if you prefer)
      bind=SUPER,D,exec,wofi --show drun

      # quit Mango
      bind=SUPER+SHIFT,E,quit,

      ##### Focus / tags (workspaces) #####
      bind=SUPER,1,view,1
      bind=SUPER,2,view,2
      bind=SUPER,3,view,3

      bind=SUPER+SHIFT,1,tag,1
      bind=SUPER+SHIFT,2,tag,2
      bind=SUPER+SHIFT,3,tag,3

      ##### Layout example (optional, Mango has lots here) #####
      # layout=master
      # master_count=1
      # gap=6
      # smartgap=1

      ##### Autostart via exec-once (in addition to autostart_sh below) #####
      # this runs once when Mango starts
      exec-once=waybar
    '';

    # This is like an inline autostart.sh; it runs at Mango start.
    # No shebang needed.
    autostart_sh = ''
      # Set wallpaper with swww if present
      if command -v swww >/dev/null 2>&1; then
        swww init || true
        swww img "$HOME/.local/share/wallpapers/default.jpg" || true
      fi
    '';
  };

  ########################
  ## Packages for Mango session
  ########################

  home.packages = with pkgs; [
    foot        # terminal
    wofi        # launcher (or fuzzel/rofi-wayland/wmenu)
    waybar      # bar
    swww        # wallpapers
    wl-clipboard
    grim slurp  # screenshots
  ];
}
