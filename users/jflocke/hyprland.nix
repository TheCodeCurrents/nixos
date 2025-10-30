{ config, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    extraConfig = ''
      # Launch terminal
      bind = SUPER, RETURN, exec, kitty

      # Launch rofi
      bind = SUPER, D, exec, rofi -show drun

      # Close focused window
      bind = SUPER, Q, killactive

      # Switch to workspace 1–5
      bind = SUPER, 1, workspace, 1
      bind = SUPER, 2, workspace, 2
      bind = SUPER, 3, workspace, 3
      bind = SUPER, 4, workspace, 4
      bind = SUPER, 5, workspace, 5

      # Move window to workspace
      bind = SUPER SHIFT, 1, movetoworkspace, 1
      bind = SUPER SHIFT, 2, movetoworkspace, 2
      bind = SUPER SHIFT, 3, movetoworkspace, 3
      bind = SUPER SHIFT, 4, movetoworkspace, 4
      bind = SUPER SHIFT, 5, movetoworkspace, 5

      # Screenshot
      bind = SUPER, S, exec, grim -g "$(slurp)" - | swappy -f -
      
      # Lock screen
      bind = SUPER, L, exec, hyprlock
      
      # Volume
      bind = SUPER, F11, exec, pactl set-sink-volume @DEFAULT_SINK@ -5%
      bind = SUPER, F12, exec, pactl set-sink-volume @DEFAULT_SINK@ +5%

      # Start hyprpaper on launch
      exec-once = hyprpaper

      input {
        kb_layout = de
        kb_model = pc105
        kb_options = caps:swapescape
        kb_rules = evdev
      }
    '';
  };

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    # Preload wallpapers
    preload = ~/nixos/wallpapers/jellyfish.jpg

    # Assign wallpaper to monitor
    wallpaper = eDP-1, ~/nixos/wallpapers/jellyfish.jpg
  '';

  programs.kitty = {
    enable = true;
  };
  
  programs.waybar.enable = true;
  programs.rofi.enable = true;
  services.mako.enable = true;

  home.packages = with pkgs; [
    wl-clipboard
    grim slurp swappy wf-recorder
    playerctl brightnessctl
    networkmanagerapplet blueman
    hyprpaper hyprlock
    xdg-desktop-portal-hyprland

    # background
    hyprpaper
  ];

  home.sessionVariables = {
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
  };


}