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

# Always show notification after action
sleep 0.3 # brief wait for playerctl to update state

STATUS=$(playerctl -p "$PLAYER" status 2>/dev/null)
TITLE=$(playerctl -p "$PLAYER" metadata title 2>/dev/null)
ARTIST=$(playerctl -p "$PLAYER" metadata artist 2>/dev/null)

case "$STATUS" in
Playing) ICON="▶" ;;
Paused) ICON="⏸" ;;
Stopped) ICON="⏹" ;;
*) ICON="?" ;;
esac

BODY="$ICON $STATUS"
[ -n "$ARTIST" ] && BODY="$BODY\n$ARTIST"
[ -n "$TITLE" ] && BODY="$BODY — $TITLE"

notify-send "$PLAYER" "$(echo -e "$BODY")" -i audio-x-generic -t 2000
