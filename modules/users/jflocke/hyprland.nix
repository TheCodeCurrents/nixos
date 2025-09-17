{ config, pkgs, ... }:
{
    wayland.windowManager.hyprland = {
        enable = true;
        settings = {
            super = "Mod4";
        };
    };

    programs.kitty = {
        enable = true;
    };
}