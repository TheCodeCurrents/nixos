#!/usr/bin/env bash
# Suspend only if no external monitor is connected

# Count connected monitors except eDP (the internal display)
external_count=$(hyprctl monitors -j | grep -c 'name' | grep -v 'eDP')

# Fallback for systems using xrandr (if hyprctl fails)
if ! command -v hyprctl >/dev/null; then
  external_count=$(xrandr --listmonitors | grep -c 'HDMI\|DP\|VGA')
fi

# If only the internal display is present, suspend
if [ "$external_count" -le 1 ]; then
  hyprlock && systemctl suspend
else
  hyprlock
fi
