#!/bin/bash
# ~/.config/hypr/scripts/player.sh

ACTION="${1:-notify}"
PLAYER=$(playerctl -l 2>/dev/null | head -1)

if [ -z "$PLAYER" ]; then
  notify-send "Player" "No active player" -i audio-x-generic -t 2000
  exit 0
fi

case "$ACTION" in
next) playerctl -p "$PLAYER" next ;;
prev) playerctl -p "$PLAYER" previous ;;
play-pause) playerctl -p "$PLAYER" play-pause ;;
esac

# Wait for player to settle after action
for _ in $(seq 1 10); do
  sleep 0.1
  STATUS=$(playerctl -p "$PLAYER" status 2>/dev/null)
  [ "$STATUS" != "Stopped" ] && break
done
TITLE=$(playerctl -p "$PLAYER" metadata title 2>/dev/null)
ARTIST=$(playerctl -p "$PLAYER" metadata artist 2>/dev/null)
ART_URL=$(playerctl -p "$PLAYER" metadata mpris:artUrl 2>/dev/null)

case "$STATUS" in
Playing) ICON="▶" ;;
Paused) ICON="⏸" ;;
Stopped) ICON="⏹" ;;
*) ICON="?" ;;
esac

BODY="$ICON $STATUS"
[ -n "$ARTIST" ] && BODY="$BODY\n$ARTIST"
[ -n "$TITLE" ] && BODY="$BODY — $TITLE"

# Resolve album art icon
NOTIF_ICON="audio-x-generic"
if [ -n "$ART_URL" ]; then
  if [[ "$ART_URL" == file://* ]]; then
    NOTIF_ICON="${ART_URL#file://}"
  elif [[ "$ART_URL" == http* ]]; then
    CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/player-art"
    mkdir -p "$CACHE_DIR"
    CACHE_FILE="$CACHE_DIR/$(echo "$ART_URL" | md5sum | cut -d' ' -f1).jpg"
    [ -f "$CACHE_FILE" ] || curl -fsSL "$ART_URL" -o "$CACHE_FILE" 2>/dev/null
    [ -f "$CACHE_FILE" ] && NOTIF_ICON="$CACHE_FILE"
  fi
fi

DISPLAY_NAME="${PLAYER%%.*}"
notify-send "$DISPLAY_NAME" "$(echo -e "$BODY")" -i "$NOTIF_ICON" -t 2000
