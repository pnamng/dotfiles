#!/usr/bin/env bash
# lock-status.sh — battery/network text for hyprlock's status-row labels

case "$1" in
  battery)
    cap=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null)
    status=$(cat /sys/class/power_supply/BAT0/status 2>/dev/null)
    icon="󰁹"
    [[ "$status" == "Charging" ]] && icon="󰂄"
    echo "${icon}  ${cap:-?}%"
    ;;
  network)
    if nmcli -t -f active,ssid dev wifi 2>/dev/null | grep -q '^yes:'; then
      echo "󰖩  Connected"
    else
      echo "󰖪  Disconnected"
    fi
    ;;
esac
