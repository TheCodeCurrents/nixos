{ config, pkgs, lib, hostName ? null, ... }:

let
  # Define your preferred apps here
  myCalculator  = "qalculate-gtk";      # change later if you want
  mySettingsApp = "rofi -show drun";    # placeholder for a real settings app
  mySnippingCmd = "grim -g \"$(slurp)\" - | wl-copy";
in
{
  imports =
    [
      ./waybar.nix
    ]
    ++ lib.optionals (hostName != null) [ (./hosts + "/${hostName}.nix") ];

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      # general settings
      general = {
        gaps_in = 4;
        gaps_out = 10;
        border_size = 2;

        "col.active_border" = "rgba(88c0d0ff)";
        "col.inactive_border" = "rgba(3b425255)";
      };

      # input settings
      input = {
        kb_layout = "de";
        follow_mouse = 1;

        natural_scroll = false;

        touchpad = {
          natural_scroll = true;
        };
      };

      # window settings
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      # decoration settings
      decoration = {
        rounding = 12;

        blur = {
          enabled = true;
          size = 6;
          passes = 3;
          new_optimizations = true;
        };

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
        };
      };

      # animation settings
      animations = {
        enabled = true;

        animations.animation = [
          "windows, 1, 3, default"
          "border, 1, 3, default"
          "fade, 1, 3, default"
          "workspaces, 1, 3, default"
        ];
      };

      # autostart applications
      exec-once = [
        "waybar"
        "swww init"
      ];

      # keybindings
      bind = [
        # basic
        "SUPER, Return, exec, kitty"
        "SUPER, Q, killactive"
        "SUPER, D, exec, rofi -show drun"
        "SUPER, M, exit"

        # workspace switching
        "SUPER, 1, workspace, 1"
        "SUPER, 2, workspace, 2"
        "SUPER, 3, workspace, 3"
        "SUPER, 4, workspace, 4"
        "SUPER, 5, workspace, 5"
        "SUPER, 6, workspace, 6"
        "SUPER, 7, workspace, 7"
        "SUPER, 8, workspace, 8"
        "SUPER, 9, workspace, 9"
        "SUPER, LEFT, workspace, prev"
        "SUPER, RIGHT, workspace, next"

        # window management
        "SUPER SHIFT, 1, movetoworkspace, 1"
        "SUPER SHIFT, 2, movetoworkspace, 2"
        "SUPER SHIFT, 3, movetoworkspace, 3"
        "SUPER SHIFT, 4, movetoworkspace, 4"
        "SUPER SHIFT, 5, movetoworkspace, 5"
        "SUPER SHIFT, 6, movetoworkspace, 6"
        "SUPER SHIFT, 7, movetoworkspace, 7"
        "SUPER SHIFT, 8, movetoworkspace, 8"
        "SUPER SHIFT, 9, movetoworkspace, 9"
        "SUPER+SHIFT, LEFT, movetoworkspace, prev"
        "SUPER+SHIFT, RIGHT, movetoworkspace, next"

        # volume
        ", XF86AudioRaiseVolume, exec, pamixer -i 5"
        ", XF86AudioLowerVolume, exec, pamixer -d 5"
        ", XF86AudioMute, exec, pamixer -t"
        ", XF86AudioMicMute, exec, pamixer --default-source -t"

        # brightness
        ", XF86MonBrightnessUp, exec, brightnessctl set +10%"
        ", XF86MonBrightnessDown, exec, brightnessctl set 10%-"

        # media playback
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"

        # lock screen
        ", XF86ScreenSaver, exec, hyprlock"

        # settings key
        ", XF86Tools, exec, ${mySettingsApp}"

        # calculator key
        ", XF86Calculator, exec, ${myCalculator}"

        # snipping tool
        ", Print, exec, ${mySnippingCmd}"
      ];

      env = [
        "XCURSOR_THEME,Bibata-Modern-Classic"
        "XCURSOR_SIZE,20"
      ];
    };
  };

  programs.kitty = {
    enable = true;
    font.name = "JetBrainsMono Nerd Font";
  };

  home.packages = with pkgs; [
    # core tools
    wl-clipboard
    grim
    slurp
    rofi
    swww

    # media / input helpers
    pamixer
    brightnessctl
    playerctl

    # apps
    qalculate-gtk
    hyprlock

    # theming
    nerd-fonts.jetbrains-mono
    bibata-cursors
  ];
}
