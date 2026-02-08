{ config, pkgs, lib, hostName ? null, ... }:

{
  imports =
    [
      ./waybar.nix
    ]
    ++ lib.optionals (hostName != null) [ (./hosts + "/${hostName}.nix") ];

  wayland.windowManager.hyprland = {
    enable = true;

    settings = {
      # ── General ────────────────────────────────────────────
      general = {
        gaps_in = 5;
        gaps_out = 14;
        border_size = 2;

        "col.active_border" = "rgba(cba6f7ff) rgba(89b4faff) 45deg";
        "col.inactive_border" = "rgba(313244aa)";

        layout = "dwindle";
        resize_on_border = true;
      };

      # ── Input ──────────────────────────────────────────────
      input = {
        kb_layout = "de";
        follow_mouse = 1;
        sensitivity = 0;
        natural_scroll = false;
        touchpad = {
          tap-to-click = true;
          natural_scroll = true;
          drag_lock = true;
          disable_while_typing = true;
        };
      };

      # ── Layout ─────────────────────────────────────────────
      dwindle = {
        pseudotile = true;
        preserve_split = true;
      };

      master = {
        new_status = "master";
      };

      # ── Decoration ─────────────────────────────────────────
      decoration = {
        rounding = 14;

        blur = {
          enabled = true;
          size = 8;
          passes = 4;
        };

        shadow = {
          enabled = true;
          range = 20;
          render_power = 3;
        };
      };

      # ── Animations ─────────────────────────────────────────
      animations = {
        enabled = true;

        bezier = [
          "wind, 0.05, 0.9, 0.1, 1.05"
          "winIn, 0.1, 1.1, 0.1, 1.1"
          "winOut, 0.3, -0.3, 0, 1"
          "liner, 1, 1, 1, 1"
          "easeOut, 0.16, 1, 0.3, 1"
        ];

        animation = [
          "windows, 1, 6, wind, slide"
          "windowsIn, 1, 6, winIn, slide"
          "windowsOut, 1, 5, winOut, slide"
          "windowsMove, 1, 5, wind, slide"
          "border, 1, 1, liner"
          "borderangle, 1, 30, liner, loop"
          "fade, 1, 10, easeOut"
          "workspaces, 1, 5, wind"
          "layers, 1, 4, easeOut, fade"
        ];
      };

      # ── Misc ───────────────────────────────────────────────
      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
        force_default_wallpaper = 0;
        vfr = true;
        vrr = 1;
        animate_manual_resizes = true;
        focus_on_activate = true;
      };

      # ── Window rules ───────────────────────────────────────
      windowrule = [
        "float on, match:class pavucontrol"
        "float on, match:class nm-connection-editor"
        "float on, match:class qalculate-gtk"
        "float on, match:class file-roller"
        "float on, match:class org.gnome.Nautilus, match:title .*Properties.*"
        "float on, match:title Picture-in-Picture"
        "float on, match:title Open File"
        "float on, match:title Save As"
        "pin on, match:title Picture-in-Picture"
        "opacity 0.92 0.88, match:class kitty"
        "opacity 0.95 0.90, match:class code|Code"
        "opacity 0.95 0.90, match:class obsidian"
        "idle_inhibit always, match:class .*"
      ];

      # ── Layer rules ────────────────────────────────────────
      layerrule = [
        "blur on, match:namespace waybar"
        "blur on, match:namespace rofi"
        "blur on, match:namespace notifications"
        "blur on, match:namespace logout_dialog"
      ];

      # ── Autostart ──────────────────────────────────────────
      exec-once = [
        "waybar"
        "swww-daemon"
        "swww img $(find ~/nixos/wallpapers -type f | shuf -n 1) --transition-type grow --transition-pos center --transition-duration 1"
        "mako"
        "hypridle"
        "wl-paste --type text --watch cliphist store"
        "wl-paste --type image --watch cliphist store"
        # Start GNOME Keyring daemons
        "dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
        "gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg"
      ];

      # ── Env vars ───────────────────────────────────────────
      env = [
        "XCURSOR_THEME,Bibata-Modern-Classic"
        "XCURSOR_SIZE,24"
        "QT_QPA_PLATFORMTHEME,qt6ct"
        "QT_WAYLAND_DISABLE_WINDOWDECORATION,1"
      ];

      # ── Keybindings ────────────────────────────────────────
      "$mod" = "SUPER";
      "$term" = "kitty";
      "$menu" = "rofi -show drun -show-icons";
      "$browser" = "firefox";
      "$filemanager" = "nautilus";

      bind = [
        # ── Launch ────────────────────────────────
        "$mod, Return, exec, $term"
        "$mod, D, exec, $menu"
        "$mod, B, exec, $browser"
        "$mod, E, exec, $filemanager"
        "$mod, V, exec, cliphist list | rofi -dmenu -p 'Clipboard' | cliphist decode | wl-copy"

        # ── Window management ─────────────────────
        "$mod, Q, killactive,"
        "$mod, F, fullscreen, 0"
        "$mod SHIFT, F, fullscreen, 1"       # maximize (keep bar)
          "$mod, T, togglefloating"
        "$mod, P, pseudo,"                    # dwindle
        "$mod, S, togglesplit,"               # dwindle
        "$mod, G, togglegroup,"
        "$mod, Tab, changegroupactive, f"

        # ── Focus movement (vim-style + arrows) ──
        "$mod, H, movefocus, l"
        "$mod, L, movefocus, r"
        "$mod, K, movefocus, u"
        "$mod, J, movefocus, d"
        "$mod, LEFT, movefocus, l"
        "$mod, RIGHT, movefocus, r"
        "$mod, UP, movefocus, u"
        "$mod, DOWN, movefocus, d"

        # ── Move windows ─────────────────────────
        "$mod SHIFT, H, movewindow, l"
        "$mod SHIFT, L, movewindow, r"
        "$mod SHIFT, K, movewindow, u"
        "$mod SHIFT, J, movewindow, d"
        "$mod SHIFT, LEFT, movewindow, l"
        "$mod SHIFT, RIGHT, movewindow, r"
        "$mod SHIFT, UP, movewindow, u"
        "$mod SHIFT, DOWN, movewindow, d"

        # ── Workspaces ───────────────────────────
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod, 5, workspace, 5"
        "$mod, 6, workspace, 6"
        "$mod, 7, workspace, 7"
        "$mod, 8, workspace, 8"
        "$mod, 9, workspace, 9"
        "$mod, 0, workspace, 10"

        # ── Move to workspace ────────────────────
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
        "$mod SHIFT, 5, movetoworkspace, 5"
        "$mod SHIFT, 6, movetoworkspace, 6"
        "$mod SHIFT, 7, movetoworkspace, 7"
        "$mod SHIFT, 8, movetoworkspace, 8"
        "$mod SHIFT, 9, movetoworkspace, 9"
        "$mod SHIFT, 0, movetoworkspace, 10"

        # ── Silent move (stay on current ws) ─────
        "$mod ALT, 1, movetoworkspacesilent, 1"
        "$mod ALT, 2, movetoworkspacesilent, 2"
        "$mod ALT, 3, movetoworkspacesilent, 3"
        "$mod ALT, 4, movetoworkspacesilent, 4"
        "$mod ALT, 5, movetoworkspacesilent, 5"

        # ── Special workspace (scratchpad) ───────
        "$mod, grave, togglespecialworkspace, magic"
        "$mod SHIFT, grave, movetoworkspace, special:magic"

        # ── Mouse workspace scroll ───────────────
        "$mod, mouse_down, workspace, e+1"
        "$mod, mouse_up, workspace, e-1"

        # ── Media keys ───────────────────────────
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ", XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPrev, exec, playerctl previous"

        # ── Brightness ───────────────────────────
        ", XF86MonBrightnessUp, exec, brightnessctl set +5%"
        ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"

        # ── Screenshot ───────────────────────────
        ", Print, exec, grim -g \"$(slurp -d)\" - | wl-copy"
        "SHIFT, Print, exec, grim - | wl-copy"
        "$mod, Print, exec, grim -g \"$(slurp -d)\" ~/Pictures/screenshot-$(date +%Y%m%d-%H%M%S).png"

        # ── Lock ─────────────────────────────────
        "$mod, backspace, exec, hyprlock"

        # ── Power menu ───────────────────────────
        "$mod SHIFT, backspace, exec, wlogout -p layer-shell"

        # ── Special keys ─────────────────────────
        ", XF86Calculator, exec, qalculate-gtk"
      ];

      # ── Resize with mod + right-click drag ────
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      # ── Resize submap ──────────────────────────
      binde = [
        "$mod CTRL, H, resizeactive, -30 0"
        "$mod CTRL, L, resizeactive, 30 0"
        "$mod CTRL, K, resizeactive, 0 -30"
        "$mod CTRL, J, resizeactive, 0 30"
        "$mod CTRL, LEFT, resizeactive, -30 0"
        "$mod CTRL, RIGHT, resizeactive, 30 0"
        "$mod CTRL, UP, resizeactive, 0 -30"
        "$mod CTRL, DOWN, resizeactive, 0 30"
      ];
    };
  };

  # ── Hyprlock ─────────────────────────────────────────────
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        grace = 5;
        hide_cursor = true;
      };

      background = [{
        path = "screenshot";
        blur_passes = 4;
        blur_size = 8;
        noise = 0.01;
        contrast = 0.8;
        brightness = 0.6;
        vibrancy = 0.17;
      }];

      input-field = [{
        size = "250, 50";
        outline_thickness = 2;
        dots_size = 0.25;
        dots_spacing = 0.3;
        dots_center = true;
        outer_color = "rgba(cba6f7ff)";
        inner_color = "rgba(1e1e2eff)";
        font_color = "rgba(cdd6f4ff)";
        fade_on_empty = false;
        placeholder_text = "<i>Password...</i>";
        hide_input = false;
        position = "0, -20";
        halign = "center";
        valign = "center";
      }];

      label = [
        {
          text = "cmd[update:1000] echo \"$(date +\"%H:%M\")\"";
          color = "rgba(cdd6f4ff)";
          font_size = 96;
          font_family = "JetBrainsMono Nerd Font Bold";
          position = "0, 150";
          halign = "center";
          valign = "center";
        }
        {
          text = "cmd[update:60000] echo \"$(date +\"%A, %d %B\")\"";
          color = "rgba(bac2deff)";
          font_size = 20;
          font_family = "JetBrainsMono Nerd Font";
          position = "0, 70";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };

  # ── Wlogout (power menu) ──────────────────────────────────
  programs.wlogout = {
    enable = true;
    layout = [
      {
        label = "lock";
        action = "hyprlock";
        text = "Lock";
        keybind = "l";
      }
      {
        label = "logout";
        action = "hyprctl dispatch exit";
        text = "Logout";
        keybind = "e";
      }
      {
        label = "suspend";
        action = "systemctl suspend";
        text = "Suspend";
        keybind = "s";
      }
      {
        label = "reboot";
        action = "systemctl reboot";
        text = "Reboot";
        keybind = "r";
      }
      {
        label = "shutdown";
        action = "systemctl poweroff";
        text = "Shutdown";
        keybind = "p";
      }
      {
        label = "hibernate";
        action = "systemctl hibernate";
        text = "Hibernate";
        keybind = "h";
      }
    ];

    style = ''
      @define-color base    #1e1e2e;
      @define-color mantle  #181825;
      @define-color surface0 #313244;
      @define-color surface1 #45475a;
      @define-color text    #cdd6f4;
      @define-color subtext0 #a6adc8;
      @define-color mauve   #cba6f7;
      @define-color blue    #89b4fa;
      @define-color sapphire #74c7ec;
      @define-color green   #a6e3a1;
      @define-color peach   #fab387;
      @define-color red     #f38ba8;
      @define-color yellow  #f9e2af;
      @define-color flamingo #f2cdcd;

      * {
        font-family: "JetBrainsMono Nerd Font";
        background-image: none;
        transition: 200ms;
      }

      window {
        background-color: alpha(@base, 0.85);
      }

      button {
        color: @text;
        background-color: alpha(@surface0, 0.6);
        border: 2px solid alpha(@surface1, 0.5);
        outline-style: none;
        border-radius: 20px;
        margin: 12px;
        background-repeat: no-repeat;
        background-position: center;
        background-size: 30%;
        box-shadow: 0 4px 8px alpha(#000000, 0.3);
      }

      button:focus,
      button:active,
      button:hover {
        background-color: alpha(@mauve, 0.2);
        border-color: @mauve;
        color: @mauve;
      }

      #lock {
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/lock.png"));
      }
      #lock:hover {
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/lock.png"));
        border-color: @blue;
        background-color: alpha(@blue, 0.2);
      }

      #logout {
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/logout.png"));
      }
      #logout:hover {
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/logout.png"));
        border-color: @peach;
        background-color: alpha(@peach, 0.2);
      }

      #suspend {
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/suspend.png"));
      }
      #suspend:hover {
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/suspend.png"));
        border-color: @sapphire;
        background-color: alpha(@sapphire, 0.2);
      }

      #reboot {
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/reboot.png"));
      }
      #reboot:hover {
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/reboot.png"));
        border-color: @yellow;
        background-color: alpha(@yellow, 0.2);
      }

      #shutdown {
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/shutdown.png"));
      }
      #shutdown:hover {
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/shutdown.png"));
        border-color: @red;
        background-color: alpha(@red, 0.2);
      }

      #hibernate {
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/hibernate.png"));
      }
      #hibernate:hover {
        background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/hibernate.png"));
        border-color: @green;
        background-color: alpha(@green, 0.2);
      }
    '';
  };

  # ── Hypridle ─────────────────────────────────────────────
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        {
          timeout = 300;
          on-timeout = "brightnessctl -s set 10";
          on-resume = "brightnessctl -r";
        }
        {
          timeout = 600;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 900;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 1800;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };

  # ── Mako (notifications) ────────────────────────────────
  services.mako = {
    enable = true;
    settings = {
      font = "JetBrainsMono Nerd Font 11";
      background-color = "#1e1e2eee";
      text-color = "#cdd6f4";
      border-color = "#cba6f7";
      border-radius = 12;
      border-size = 2;
      padding = "12";
      margin = "14";
      max-visible = 4;
      default-timeout = 5000;
      layer = "overlay";

      "[urgency=critical]" = {
        border-color = "#f38ba8";
        default-timeout = 0;
      };
    };
  };

  # ── Rofi ─────────────────────────────────────────────────
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    terminal = "kitty";
    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        bg = mkLiteral "#1e1e2eee";
        bg-alt = mkLiteral "#313244";
        fg = mkLiteral "#cdd6f4";
        accent = mkLiteral "#cba6f7";
        urgent = mkLiteral "#f38ba8";
        border-radius = mkLiteral "14px";
        background-color = mkLiteral "@bg";
        text-color = mkLiteral "@fg";
      };

      window = {
        width = mkLiteral "600px";
        padding = mkLiteral "20px";
        border = mkLiteral "2px solid";
        border-color = mkLiteral "@accent";
        border-radius = mkLiteral "14px";
      };

      inputbar = {
        children = map mkLiteral [ "prompt" "entry" ];
        padding = mkLiteral "12px";
        spacing = mkLiteral "12px";
        background-color = mkLiteral "@bg-alt";
        border-radius = mkLiteral "10px";
      };

      prompt = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@accent";
      };

      entry = {
        background-color = mkLiteral "transparent";
        placeholder = "Search...";
        placeholder-color = mkLiteral "#6c7086";
      };

      listview = {
        columns = 1;
        lines = 8;
        padding = mkLiteral "8px 0 0 0";
        fixed-height = true;
        spacing = mkLiteral "4px";
      };

      element = {
        padding = mkLiteral "10px";
        spacing = mkLiteral "10px";
        border-radius = mkLiteral "10px";
      };

      "element selected" = {
        background-color = mkLiteral "@accent";
        text-color = mkLiteral "#1e1e2e";
      };

      "element-icon" = {
        size = mkLiteral "24px";
        background-color = mkLiteral "transparent";
      };

      "element-text" = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
      };
    };
  };

  # ── Kitty ────────────────────────────────────────────────
  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };
    settings = {
      background_opacity = "0.92";
      confirm_os_window_close = 0;
      window_padding_width = 8;
      scrollback_lines = 10000;
      enable_audio_bell = false;
      copy_on_select = "clipboard";
      cursor_shape = "beam";
    };
  };

  # ── Packages ─────────────────────────────────────────────
  home.packages = with pkgs; [
    # wayland core
    wl-clipboard
    cliphist
    grim
    slurp
    swww
    wtype
    wlogout

    # media / input helpers
    brightnessctl
    playerctl
    pavucontrol
    poweralertd

    # apps
    qalculate-gtk
    networkmanagerapplet

    # theming
    nerd-fonts.jetbrains-mono
    bibata-cursors
    libnotify
    # keyring
    gnome-keyring
  ];
}
