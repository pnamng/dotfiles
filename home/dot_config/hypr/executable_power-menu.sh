#!/bin/bash

# Fuzzel Power Menu
# A simple power management menu using fuzzel

# Define power options
options="⏻ Shutdown\n⟳ Reboot\n⏾ Suspend\n🚪 Logout\n🔒 Lock Screen"

# Show menu and get selection
selected=$(echo -e "$options" | fuzzel --dmenu --prompt "Power: " --width 25)

# Execute selected option
case $selected in
"⏻ Shutdown")
  systemctl poweroff
  ;;
"⟳ Reboot")
  systemctl reboot
  ;;
"⏾ Suspend")
  systemctl suspend
  #   ;;
  # "⏾ Hibernate")
  #   systemctl hibernate
  ;;
"🚪 Logout")
  # Detect session type and logout accordingly
  if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    if [ "$XDG_CURRENT_DESKTOP" = "sway" ]; then
      swaymsg exit
    elif [ "$XDG_CURRENT_DESKTOP" = "Hyprland" ]; then
      hyprctl dispatch exit
    else
      loginctl terminate-session "$XDG_SESSION_ID"
    fi
  else
    loginctl terminate-session "$XDG_SESSION_ID"
  fi
  ;;
"🔒 Lock Screen")
  # Try different lock commands
  if command -v swaylock &>/dev/null; then
    swaylock -f
  elif command -v hyprlock &>/dev/null; then
    hyprlock
  elif command -v gtklock &>/dev/null; then
    gtklock
  else
    notify-send "Error" "No lock screen program found"
  fi
  ;;
*)
  exit 0
  ;;
esac
