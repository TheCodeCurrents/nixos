{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland.settings.monitor = [
    # Left monitor (rotated 90° clockwise) — unchanged
    "DP-1,2560x1440@59.95,0x0,1,transform,1"

    # Right monitor (normal, LOWER)
    "DP-2,2560x1440@59.95,1440x1080,1"
  ];
}
