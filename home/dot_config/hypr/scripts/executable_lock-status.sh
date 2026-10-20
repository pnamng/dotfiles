#!/usr/bin/env bash
# lock-status.sh — text for hyprlock's status labels

# hyprlock reads label text as pango markup, so a title with & or < in it
# would otherwise blank the label
escape() { sed -e 's/&/\&amp;/g' -e 's/</\&lt;/g' -e 's/>/\&gt;/g'; }

clip() { local s="$1" n="$2"; (( ${#s} > n )) && s="${s:0:n-1}…"; printf '%s' "$s"; }

# the player that is playing, or else the first one there is
player() {
  local p first=""
  for p in $(playerctl -l 2>/dev/null); do
    [[ -z "$first" ]] && first="$p"
    [[ "$(playerctl -p "$p" status 2>/dev/null)" == "Playing" ]] && { echo "$p"; return; }
  done
  echo "$first"
}

case "$1" in
  battery)
    cap=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null)
    status=$(cat /sys/class/power_supply/BAT0/status 2>/dev/null)
    [[ -z "$cap" ]] && exit 0
    if [[ "$status" == "Charging" ]]; then
      echo "${cap}% · charging"
    else
      echo "${cap}%"
    fi
    ;;
  media-status)
    p=$(player)
    # a browser registers as a player with no track, which is still nothing playing
    if [[ -z "$p" || -z "$(playerctl -p "$p" metadata title 2>/dev/null)" ]]; then
      echo "nothing playing"; exit 0
    fi
    st=$(playerctl -p "$p" status 2>/dev/null | tr '[:upper:]' '[:lower:]')
    echo "${st:-stopped} · ${p%%.*}" | escape
    ;;
  media-title)
    p=$(player); [[ -z "$p" ]] && exit 0
    clip "$(playerctl -p "$p" metadata title 2>/dev/null)" 36 | escape
    ;;
  media-artist)
    p=$(player); [[ -z "$p" ]] && exit 0
    clip "$(playerctl -p "$p" metadata artist 2>/dev/null)" 40 | escape
    ;;
esac
