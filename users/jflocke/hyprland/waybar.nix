{ pkgs, ... }:

{
  home.packages = with pkgs; [
    waybar
  ];

  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 32;
        margin-top = 6;
        margin-left = 6;
        margin-right = 6;

        spacing = 0;

        modules-left = [
          "hyprland/workspaces"
        ];

        modules-center = [
          "clock"
        ];

        modules-right = [
          "network"
          "pulseaudio"
          "cpu"
          "memory"
          "battery"
        ];

        # -------- Modules --------
        clock = {
          format = " {:%H:%M}";
          tooltip-format = "{:%A, %d %B %Y}";
        };

        network = {
          format-wifi = "󰤨 {signalStrength}%";
          format-ethernet = "󰈀 wired";
          format-disconnected = "󰤭";
          tooltip = true;
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-muted = "󰝟 muted";
          scroll-step = 5;
          format-icons = {
            headphone = "󰋋";
            hands-free = "󰋋";
            headset = "󰋋";
            phone = "󰋋";
            portable = "󰋋";
            car = "󰋋";
            default = [ "󰕿" "󰖀" "󰕾" ];
          };
          on-click = "pavucontrol";
        };

        cpu = {
          format = "󰍛 {usage}%";
          tooltip = true;
        };

        memory = {
          format = "󰆼 {percentage}%";
          tooltip = true;
        };

        battery = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = "󰂄 {capacity}%";
          format-plugged = "󰂄 {capacity}%";
          format-icons = [
            "󰁺" "󰁻" "󰁼" "󰁽"
            "󰁾" "󰁿" "󰂀" "󰂁"
            "󰂂" "󰁹"
          ];
        };
      };
    };

    style = ''
      * {
        font-family: JetBrainsMono Nerd Font;
        font-size: 12px;
        border: none;
        border-radius: 0;
        min-height: 0;
        transition: background 200ms cubic-bezier(0.4, 0.0, 0.2, 1);
      }

      window#waybar {
        background: transparent;
      }

      /* Group containers */
      .modules-left,
      .modules-center,
      .modules-right {
        background: rgba(40, 44, 52, 0.8);
        border-radius: 16px;
        padding: 6px 0;
        margin: 0 8px;
        border: 1px solid rgba(229, 233, 240, 0.15);
      }

      /* Shared module base style */
      #workspaces button,
      #clock,
      #network,
      #pulseaudio,
      #cpu,
      #memory,
      #battery {
        padding: 8px 14px;
        margin: 0 2px;
        color: #e5e9f0;
        border-radius: 12px;
      }

      /* Workspaces module */
      #workspaces {
        margin-right: 4px;
      }

      #workspaces button {
        color: #d8dee9;
        background: transparent;
        min-width: 32px;
      }

      #workspaces button.active {
        background: #88c0d0;
        color: #2e3440;
        font-weight: bold;
      }

      #workspaces button:hover {
        background: rgba(136, 192, 208, 0.3);
        color: #88c0d0;
      }

      /* Clock - emphasized */
      #clock {
        background: rgba(136, 192, 208, 0.15);
        color: #88c0d0;
        font-weight: 500;
        margin: 0 4px;
      }

      #clock:hover {
        background: rgba(136, 192, 208, 0.3);
      }

      /* Right-side modules */
      #network,
      #pulseaudio,
      #cpu,
      #memory,
      #battery {
        background: rgba(76, 86, 106, 0.4);
      }

      #network:hover,
      #pulseaudio:hover,
      #cpu:hover,
      #memory:hover,
      #battery:hover {
        background: rgba(136, 192, 208, 0.25);
      }

      /* Network */
      #network {
        color: #81a1c1;
      }

      /* Pulseaudio */
      #pulseaudio {
        color: #a3be8c;
      }

      #pulseaudio.muted {
        background: rgba(191, 97, 106, 0.3);
        color: #bf616a;
      }

      /* CPU */
      #cpu {
        color: #b48ead;
      }

      /* Memory */
      #memory {
        color: #d08770;
      }

      /* Battery states */
      #battery {
        color: #a3be8c;
      }

      #battery.charging,
      #battery.plugged {
        background: rgba(163, 190, 140, 0.25);
        color: #a3be8c;
      }

      #battery.warning {
        background: rgba(235, 203, 139, 0.35);
        color: #ebcb8b;
      }

      #battery.critical {
        background: rgba(191, 97, 106, 0.4);
        color: #eceff4;
      }

      /* Subtle separators for right modules - using borders instead */
    '';
  };
}