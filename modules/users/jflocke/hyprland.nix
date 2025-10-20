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
  
  programs.waybar.enable = true;
  programs.rofi.enable = true;
  services.mako.enable = true;

  home.packages = with pkgs; [
    wl-clipboard
    grim slurp  # screenshots
    pavucontrol # audio control
  ];

}