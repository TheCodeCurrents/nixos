{ pkgs, lib, ... }:

let
  powerProfileGet = pkgs.writeShellScript "power-profile-get" ''
    p=$(powerprofilesctl get)
    echo "{\"text\":\"$p\",\"alt\":\"$p\",\"tooltip\":\"Power profile: $p\"}"
  '';

  powerProfileCycle = pkgs.writeShellScript "power-profile-cycle" ''
    case "$(powerprofilesctl get)" in
      power-saver)  powerprofilesctl set balanced    ;;
      balanced)     powerprofilesctl set performance ;;
      performance)  powerprofilesctl set power-saver ;;
    esac
    pkill -RTMIN+8 waybar
  '';

  powerProfileCycleReverse = pkgs.writeShellScript "power-profile-cycle-reverse" ''
    case "$(powerprofilesctl get)" in
      performance)  powerprofilesctl set balanced    ;;
      balanced)     powerprofilesctl set power-saver ;;
      power-saver)  powerprofilesctl set performance ;;
    esac
    pkill -RTMIN+8 waybar
  '';
in
{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 38;
        margin-top = 8;
        margin-left = 10;
        margin-right = 10;
        spacing = 0;
        reload_style_on_change = true;

        modules-left = [
          "hyprland/workspaces"
          "hyprland/window"
        ];

        modules-center = [
          "clock"
        ];

        modules-right = [
          "tray"
          "idle_inhibitor"
          "pulseaudio"
          "network"
          "cpu"
          "memory"
          "backlight"
          "battery"
          "custom/power-profile"
          "custom/power"
        ];

        # ── Workspaces ────────────────────────────
        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "9";
            "10" = "10";
          };
          persistent-workspaces = {
            "*" = 5;
          };
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
        };

        # ── Window title ──────────────────────────
        "hyprland/window" = {
          format = "{}";
          max-length = 40;
          rewrite = {
            "(.*) — Mozilla Firefox" = "󰈹 $1";
            "(.*) - Visual Studio Code" = "󰨞 $1";
            "(.*)kitty" = " Terminal";
          };
          separate-outputs = true;
        };

        # ── Clock ─────────────────────────────────
        clock = {
          format = "  {:%H:%M}";
          format-alt = "  {:%A, %d %B %Y}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "year";
            mode-mon-col = 3;
            weeks-pos = "right";
            on-scroll = 1;
            format = {
              months = "<span color='#cba6f7'><b>{}</b></span>";
              days = "<span color='#cdd6f4'>{}</span>";
              weeks = "<span color='#89b4fa'><b>W{}</b></span>";
              weekdays = "<span color='#fab387'><b>{}</b></span>";
              today = "<span color='#a6e3a1'><b><u>{}</u></b></span>";
            };
          };
        };

        # ── Tray ──────────────────────────────────
        tray = {
          icon-size = 16;
          spacing = 8;
        };

        # ── Idle inhibitor ────────────────────────
        idle_inhibitor = {
          format = "{icon}";
          format-icons = {
            activated = "󰅶";
            deactivated = "󰾪";
          };
          tooltip-format-activated = "Idle inhibitor: ON";
          tooltip-format-deactivated = "Idle inhibitor: OFF";
        };

        # ── Pulseaudio ────────────────────────────
        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = "󰝟  muted";
          format-bluetooth = "󰂯 {volume}%";
          scroll-step = 5;
          format-icons = {
            headphone = "󰋋";
            default = [ "󰕿" "󰖀" "󰕾" ];
          };
          on-click = "pavucontrol";
          tooltip-format = "{desc} · {volume}%";
        };

        # ── Network ───────────────────────────────
        network = {
          format-wifi = "{icon}";
          format-ethernet = "󰈀";
          format-disconnected = "󰤭";
          format-linked = "󰈁";
          format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
          interval = 5;
          tooltip-format-wifi = "  {essid}\n󰤨  {signalStrength}%\n󰩟  {ipaddr}/{cidr}\n  {bandwidthUpBytes}    {bandwidthDownBytes}";
          tooltip-format-ethernet = "󰈀  Wired\n󰩟  {ipaddr}/{cidr}\n  {bandwidthUpBytes}    {bandwidthDownBytes}";
          tooltip-format-disconnected = "󰤭  Disconnected";
          on-click = "nm-connection-editor";
        };

        # ── CPU ───────────────────────────────────
        cpu = {
           format = "󰘚 {usage}%";
           interval = 5;
           tooltip = true;
           format-icons = [ "󰘚" ];
        };

        # ── Memory ────────────────────────────────
        memory = {
           format = "󰍛 {percentage}%";
           interval = 5;
           tooltip-format = "{used:0.1f} GiB / {total:0.1f} GiB";
           format-icons = [ "󰍛" ];
        };

        # ── Backlight ─────────────────────────────
        backlight = {
          format = "{icon} {percent}%";
          format-icons = [ "󰃞" "󰃟" "󰃠" ];
          tooltip = true;
          on-scroll-up = "brightnessctl set +5%";
          on-scroll-down = "brightnessctl set 5%-";
        };

        # ── Battery ───────────────────────────────
        battery = {
          states = {
            good = 80;
            warning = 30;
            critical = 15;
          };
          format = "{icon}  {capacity}%";
          format-charging = "󰂄  {capacity}%";
          format-plugged = "  {capacity}%";
          format-full = "  full";
          format-icons = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
          tooltip-format = "{timeTo} · {power:.1f}W";
        };

        # ── Power profile indicator ────────────────
        "custom/power-profile" = {
          format = "{icon}";
          format-icons = {
            "power-saver" = "󰌪";
            "balanced" = "󰗑";
            "performance" = "󱐋";
          };
          exec = "${powerProfileGet}";
          return-type = "json";
          exec-on-event = true;
          interval = 60;
          signal = 8;
          on-click = "${powerProfileCycle}";
          on-click-right = "${powerProfileCycleReverse}";
          tooltip = true;
        };

        # ── Power menu ────────────────────────────
        "custom/power" = {
          format = "⏻";
          tooltip = true;
          tooltip-format = "Power Menu";
          on-click = "wlogout -p layer-shell";
        };
      };
    };

    # ── Catppuccin Mocha Waybar CSS ──────────────────────
    style = ''
      /* ── Palette (Catppuccin Mocha) ──────────────── */
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
      @define-color lavender #b4befe;

      * {
        font-family: "JetBrainsMono Nerd Font";
        font-size: 13px;
        font-weight: 500;
        border: none;
        border-radius: 0;
        min-height: 0;
      }

      window#waybar {
        background: transparent;
      }

      /* ── Container pills ────────────────────────── */
      .modules-left,
      .modules-center,
      .modules-right {
        background: alpha(@base, 0.82);
        border-radius: 16px;
        padding: 0 4px;
        margin: 0 4px;
        border: 1px solid alpha(@surface1, 0.5);
      }

      /* ── Shared module style ────────────────────── */
      #workspaces button,
      #window,
      #clock,
      #tray,
      #idle_inhibitor,
      #pulseaudio,
      #network,
      #cpu,
      #memory,
      #backlight,
      #battery,
      #custom-power-profile,
      #custom-power {
        padding: 0 12px;
        margin: 4px 2px;
        color: @text;
        border-radius: 12px;
        transition: all 200ms ease;
      }

      /* ── Workspaces ─────────────────────────────── */
      #workspaces {
        padding: 0 2px;
      }

      #workspaces button {
        color: @subtext0;
        background: transparent;
        padding: 0 8px;
        min-width: 28px;
        font-size: 12px;
      }

      #workspaces button.active {
        background: alpha(@mauve, 0.25);
        color: @mauve;
        font-weight: bold;
      }

      #workspaces button.empty {
        color: @surface1;
      }

      #workspaces button:hover {
        background: alpha(@mauve, 0.12);
        color: @lavender;
      }

      /* ── Window title ───────────────────────────── */
      #window {
        color: @subtext0;
        font-style: italic;
        padding: 0 16px;
      }

      /* ── Clock ──────────────────────────────────── */
      #clock {
        color: @mauve;
        font-weight: 700;
        font-size: 13px;
        padding: 0 16px;
      }

      #clock:hover {
        background: alpha(@mauve, 0.12);
      }

      /* ── Tray ───────────────────────────────────── */
      #tray {
        padding: 0 8px;
      }

      #tray > .passive {
        -gtk-icon-effect: dim;
      }

      #tray > .needs-attention {
        -gtk-icon-effect: highlight;
      }

      /* ── Idle inhibitor ─────────────────────────── */
      #idle_inhibitor {
        color: @subtext0;
      }

      #idle_inhibitor.activated {
        color: @yellow;
        background: alpha(@yellow, 0.12);
      }

      /* ── Pulseaudio ─────────────────────────────── */
      #pulseaudio {
        color: @green;
      }

      #pulseaudio:hover {
        background: alpha(@green, 0.12);
      }

      #pulseaudio.muted {
        color: @red;
        background: alpha(@red, 0.1);
      }

      /* ── Network ────────────────────────────────── */
      #network {
        color: @sapphire;
        font-size: 16px;
        padding: 0 10px;
      }

      #network:hover {
        background: alpha(@sapphire, 0.15);
        border-radius: 12px;
      }

      #network.disconnected {
        color: @surface1;
        font-size: 14px;
      }

      #network.linked {
        color: @blue;
      }

      #network.ethernet {
        color: @green;
      }

      /* ── CPU ────────────────────────────────────── */
      #cpu {
        color: @lavender;
      }

      #cpu:hover {
        background: alpha(@lavender, 0.12);
      }

      /* ── Memory ─────────────────────────────────── */
      #memory {
        color: @peach;
      }

      #memory:hover {
        background: alpha(@peach, 0.12);
      }

      /* ── Backlight ──────────────────────────────── */
      #backlight {
        color: @yellow;
      }

      #backlight:hover {
        background: alpha(@yellow, 0.12);
      }

      /* ── Battery ────────────────────────────────── */
      #battery {
        color: @green;
      }

      #battery:hover {
        background: alpha(@green, 0.12);
      }

      #battery.charging,
      #battery.plugged {
        color: @green;
        background: alpha(@green, 0.1);
      }

      #battery.good {
        color: @green;
      }

      #battery.warning {
        color: @yellow;
        background: alpha(@yellow, 0.1);
      }

      #battery.critical {
        color: @base;
        background: @red;
        font-weight: bold;
        animation: blink 0.8s ease infinite alternate;
      }

      @keyframes blink {
        to {
          background: alpha(@red, 0.5);
          color: @text;
        }
      }

      /* ── Power profile indicator ────────────────── */
      #custom-power-profile {
        color: @flamingo;
        font-size: 15px;
        padding: 0 10px;
      }

      #custom-power-profile:hover {
        background: alpha(@flamingo, 0.15);
        border-radius: 12px;
      }

      /* ── Power menu button ─────────────────────── */
      #custom-power {
        color: @red;
        font-size: 16px;
        padding: 0 12px;
        margin-left: 4px;
      }

      #custom-power:hover {
        background: alpha(@red, 0.18);
        border-radius: 12px;
      }
    '';
  };
}
