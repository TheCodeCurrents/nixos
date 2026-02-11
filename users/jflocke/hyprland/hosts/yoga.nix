{ config, pkgs, ... }:

let
  powerProfileCycle = pkgs.writeShellScript "power-profile-cycle" ''
    case "$(powerprofilesctl get)" in
      power-saver)  powerprofilesctl set balanced    ;;
      balanced)     powerprofilesctl set performance ;;
      performance)  powerprofilesctl set power-saver ;;
    esac
    pkill -RTMIN+8 waybar
    notify-send -t 2000 -i battery "  Power Profile" "$(powerprofilesctl get)"
  '';

  powerProfileCycleReverse = pkgs.writeShellScript "power-profile-cycle-reverse" ''
    case "$(powerprofilesctl get)" in
      performance)  powerprofilesctl set balanced    ;;
      balanced)     powerprofilesctl set power-saver ;;
      power-saver)  powerprofilesctl set performance ;;
    esac
    pkill -RTMIN+8 waybar
    notify-send -t 2000 -i battery "  Power Profile" "$(powerprofilesctl get)"
  '';
in
{
  wayland.windowManager.hyprland.settings = {
    monitor = [
      # Built-in 4K screen (exact mode and scale)
      "eDP-1,3200x2000@165.00,0x0,1.67"
      # QHD external monitor (exact mode and scale)
      "HDMI-A-1,2560x1440@59.95,auto,1.33"
    ];

    # ── Power management / lid behaviour ──────────────────
    bindl = [
      # Lid close → lock & suspend (only if no external monitor)
      ", switch:on:Lid Switch, exec, ${./suspend_if_no_external.sh}"
      # Lid open  → restore display
      ", switch:off:Lid Switch, exec, hyprctl dispatch dpms on"
    ];

    # ── Power profile keybinds ────────────────────────────
    bind = [
      "SUPER, F7, exec, ${powerProfileCycle}"
      "SUPER, F8, exec, ${powerProfileCycleReverse}"
    ];

    # ── Autostart (yoga-specific) ─────────────────────────
    exec-once = [
      "poweralertd"
    ];

    # ── Touch gestures for laptop ─────────────────────────
    gestures = {
      workspace_swipe_distance = 250;
      workspace_swipe_cancel_ratio = 0.25;
      workspace_swipe_min_speed_to_force = 15;
      workspace_swipe_create_new = false;
    };

    # ── Laptop-specific input tweaks ──────────────────────
    input = {
      touchpad = {
        tap-to-click = true;
        natural_scroll = true;
        drag_lock = true;
        disable_while_typing = true;
        clickfinger_behavior = true;
        scroll_factor = 0.7;
      };
    };
  };
}