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
        height = 36;

        spacing = 8;

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
        border-radius: 12px;
        min-height: 0;
      }

      window#waybar {
        background: transparent;
      }

      .modules-left,
      .modules-center,
      .modules-right {
        margin: 6px 10px;
      }

      /* Shared module style */
      #workspaces button,
      #clock,
      #network,
      #pulseaudio,
      #cpu,
      #memory,
      #battery {
        padding: 6px 12px;
        margin: 0 4px;
        background: rgba(40, 44, 52, 0.85);
        color: #e5e9f0;
      }

      /* Workspaces */
      #workspaces button {
        color: #d8dee9;
      }

      #workspaces button.active {
        background: #88c0d0;
        color: #2e3440;
      }

      #workspaces button:hover {
        background: rgba(136, 192, 208, 0.4);
      }

      /* Battery states */
      #battery.warning {
        background: rgba(235, 203, 139, 0.85);
        color: #2e3440;
      }

      #battery.critical {
        background: rgba(191, 97, 106, 0.85);
        color: #eceff4;
      }
    '';
  };
}