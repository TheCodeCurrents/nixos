{ config, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      monitor = ",preferred,auto,1";

      exec-once = [
        "waybar"
        "swww init"
      ];

      input = {
        kb_layout = "us";
      };

      bind = [
        "SUPER, Return, exec, kitty"
        "SUPER, Q, killactive"
        "SUPER, D, exec, rofi -show drun"
        "SUPER, M, exit"
      ];
    };
  };

  home.packages = with pkgs; [
    wl-clipboard
    grim
    slurp
    waybar
    rofi-wayland
    swww
  ];
}
