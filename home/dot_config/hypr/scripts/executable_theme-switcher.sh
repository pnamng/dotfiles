#!/usr/bin/env bash
# Theme switcher — fuzzel menu → applies colors to all configs, reloads services

CURRENT_THEME_FILE="$HOME/.config/hypr/current-theme"
CURRENT_THEME=$(cat "$CURRENT_THEME_FILE" 2>/dev/null || echo "ayu-dark")

# ─── Theme definitions ────────────────────────────────────────────────────────

declare -A THEME_NAMES=(
  [ayu-dark]="Ayu Dark"
  [catppuccin-mocha]="Catppuccin Mocha"
  [everforest-dark]="Everforest Dark"
  [oxocarbon-dark]="Oxocarbon Dark"
)

# Hex (no #)
declare -A BG=([ayu-dark]="0d1017" [catppuccin-mocha]="1e1e2e" [everforest-dark]="2d353b" [oxocarbon-dark]="161616")
declare -A FG=([ayu-dark]="bfbdb6" [catppuccin-mocha]="cdd6f4" [everforest-dark]="d3c6aa" [oxocarbon-dark]="f2f4f8")
declare -A PRIMARY=([ayu-dark]="39bae6" [catppuccin-mocha]="89b4fa" [everforest-dark]="7fbbb3" [oxocarbon-dark]="78a9ff")
declare -A ACCENT=([ayu-dark]="e6b450" [catppuccin-mocha]="f9e2af" [everforest-dark]="dbbc7f" [oxocarbon-dark]="f1c21b")
declare -A COMMENT=([ayu-dark]="626a73" [catppuccin-mocha]="6c7086" [everforest-dark]="859289" [oxocarbon-dark]="525252")
declare -A RED=([ayu-dark]="f07178" [catppuccin-mocha]="f38ba8" [everforest-dark]="e67e80" [oxocarbon-dark]="ff8389")
declare -A GREEN=([ayu-dark]="7fd962" [catppuccin-mocha]="a6e3a1" [everforest-dark]="a7c080" [oxocarbon-dark]="42be65")
declare -A PURPLE=([ayu-dark]="d2a6ff" [catppuccin-mocha]="cba6f7" [everforest-dark]="d699b6" [oxocarbon-dark]="be95ff")
declare -A TEAL=([ayu-dark]="95e6cb" [catppuccin-mocha]="94e2d5" [everforest-dark]="83c092" [oxocarbon-dark]="3ddbd9")
declare -A ORANGE=([ayu-dark]="ff8f40" [catppuccin-mocha]="fab387" [everforest-dark]="e69875" [oxocarbon-dark]="ff832b")
declare -A SURFACE=([ayu-dark]="3d4554" [catppuccin-mocha]="313244" [everforest-dark]="3d484d" [oxocarbon-dark]="393939")
declare -A PRIMARY_LIGHT=([ayu-dark]="59c2ff" [catppuccin-mocha]="b4d0ff" [everforest-dark]="a5d1cc" [oxocarbon-dark]="97c1ff")
declare -A ACCENT_LIGHT=([ayu-dark]="ffb454" [catppuccin-mocha]="ffeecf" [everforest-dark]="ecd6a7" [oxocarbon-dark]="f5d365")
declare -A GREEN_LIGHT=([ayu-dark]="aad94c" [catppuccin-mocha]="ccf0c7" [everforest-dark]="c1d9a8" [oxocarbon-dark]="6fdc8c")
declare -A PURPLE_LIGHT=([ayu-dark]="e0c4ff" [catppuccin-mocha]="e5d4ff" [everforest-dark]="e8c3d8" [oxocarbon-dark]="d0b0ff")
declare -A TEAL_LIGHT=([ayu-dark]="b3edd8" [catppuccin-mocha]="c2f0ea" [everforest-dark]="a8d6b4" [oxocarbon-dark]="6ddcdc")
declare -A FUZZEL_SEL=([ayu-dark]="25334099" [catppuccin-mocha]="45475aaa" [everforest-dark]="4a555baa" [oxocarbon-dark]="39393999")
declare -A HYPR_INACTIVE=([ayu-dark]="1e2530aa" [catppuccin-mocha]="2a2a3eaa" [everforest-dark]="3d484daa" [oxocarbon-dark]="1e1e1eaa")
declare -A GHOSTTY_THEME=([ayu-dark]="Gruvbox Dark Hard" [catppuccin-mocha]="Catppuccin Mocha" [everforest-dark]="Everforest Dark Hard" [oxocarbon-dark]="Oxocarbon")
declare -A WALLPAPER=([ayu-dark]="nebula.png" [catppuccin-mocha]="bluesky.png" [everforest-dark]="island_lowlight.png" [oxocarbon-dark]="black_sand.jpg")

# RGB decimal triplets (for rgba() in hyprlock + waybar)
declare -A BG_RGB=([ayu-dark]="13, 16, 23" [catppuccin-mocha]="30, 30, 46" [everforest-dark]="45, 53, 59" [oxocarbon-dark]="22, 22, 22")
declare -A FG_RGB=([ayu-dark]="191, 189, 182" [catppuccin-mocha]="205, 214, 244" [everforest-dark]="211, 198, 170" [oxocarbon-dark]="242, 244, 248")
declare -A PRIMARY_RGB=([ayu-dark]="57, 186, 230" [catppuccin-mocha]="137, 180, 250" [everforest-dark]="127, 187, 179" [oxocarbon-dark]="120, 169, 255")
declare -A ACCENT_RGB=([ayu-dark]="230, 180, 80" [catppuccin-mocha]="249, 226, 175" [everforest-dark]="219, 188, 127" [oxocarbon-dark]="241, 194, 27")
declare -A COMMENT_RGB=([ayu-dark]="98, 106, 115" [catppuccin-mocha]="108, 112, 134" [everforest-dark]="133, 146, 137" [oxocarbon-dark]="82, 82, 82")
declare -A RED_RGB=([ayu-dark]="240, 113, 120" [catppuccin-mocha]="243, 139, 168" [everforest-dark]="230, 126, 128" [oxocarbon-dark]="255, 131, 137")
declare -A SURFACE_RGB=([ayu-dark]="57, 62, 78" [catppuccin-mocha]="49, 50, 68" [everforest-dark]="61, 72, 77" [oxocarbon-dark]="57, 57, 57")

# ─── Fuzzel menu ─────────────────────────────────────────────────────────────

MENU_ITEMS=""
for key in ayu-dark catppuccin-mocha everforest-dark oxocarbon-dark; do
  label="${THEME_NAMES[$key]}"
  [[ "$key" == "$CURRENT_THEME" ]] && label+=" (active)"
  MENU_ITEMS+="$label\n"
done

SELECTED=$(printf "%b" "$MENU_ITEMS" | sed '/^$/d' |
  fuzzel --dmenu --prompt "Theme: " --width 30 --lines 4)

[[ -z "$SELECTED" ]] && exit 0

# Map display name back to key
NEW_THEME=""
for key in ayu-dark catppuccin-mocha everforest-dark oxocarbon-dark; do
  [[ "$SELECTED" == "${THEME_NAMES[$key]}"* ]] && NEW_THEME="$key" && break
done

[[ -z "$NEW_THEME" || "$NEW_THEME" == "$CURRENT_THEME" ]] && exit 0

OLD="$CURRENT_THEME"
NEW="$NEW_THEME"

# ─── Apply theme ──────────────────────────────────────────────────────────────

# hyprland.conf
sed -i \
  -e "s/rgba(${PRIMARY[$OLD]}ff)/rgba(${PRIMARY[$NEW]}ff)/g" \
  -e "s/rgba(${HYPR_INACTIVE[$OLD]})/rgba(${HYPR_INACTIVE[$NEW]})/g" \
  ~/.config/hypr/hyprland.conf

# waybar/style.css — hex colors
sed -i \
  -e "s/#${BG[$OLD]}/#${BG[$NEW]}/g" \
  -e "s/#${FG[$OLD]}/#${FG[$NEW]}/g" \
  -e "s/#${PRIMARY_LIGHT[$OLD]}/#${PRIMARY_LIGHT[$NEW]}/g" \
  -e "s/#${PRIMARY[$OLD]}/#${PRIMARY[$NEW]}/g" \
  -e "s/#${ACCENT_LIGHT[$OLD]}/#${ACCENT_LIGHT[$NEW]}/g" \
  -e "s/#${ACCENT[$OLD]}/#${ACCENT[$NEW]}/g" \
  -e "s/#${GREEN_LIGHT[$OLD]}/#${GREEN_LIGHT[$NEW]}/g" \
  -e "s/#${GREEN[$OLD]}/#${GREEN[$NEW]}/g" \
  -e "s/#${RED[$OLD]}/#${RED[$NEW]}/g" \
  -e "s/#${PURPLE_LIGHT[$OLD]}/#${PURPLE_LIGHT[$NEW]}/g" \
  -e "s/#${PURPLE[$OLD]}/#${PURPLE[$NEW]}/g" \
  -e "s/#${TEAL_LIGHT[$OLD]}/#${TEAL_LIGHT[$NEW]}/g" \
  -e "s/#${TEAL[$OLD]}/#${TEAL[$NEW]}/g" \
  -e "s/#${ORANGE[$OLD]}/#${ORANGE[$NEW]}/g" \
  -e "s/#${SURFACE[$OLD]}/#${SURFACE[$NEW]}/g" \
  ~/.config/waybar/style.css

# waybar/style.css — rgba decimal triplets (replace RGB part, preserving alpha)
sed -i \
  -e "s/${SURFACE_RGB[$OLD]}/${SURFACE_RGB[$NEW]}/g" \
  -e "s/${PRIMARY_RGB[$OLD]}/${PRIMARY_RGB[$NEW]}/g" \
  -e "s/${ACCENT_RGB[$OLD]}/${ACCENT_RGB[$NEW]}/g" \
  -e "s/${BG_RGB[$OLD]}/${BG_RGB[$NEW]}/g" \
  ~/.config/waybar/style.css

# mako/config
sed -i \
  -e "s/background-color=#${BG[$OLD]}e6/background-color=#${BG[$NEW]}e6/g" \
  -e "s/text-color=#${FG[$OLD]}/text-color=#${FG[$NEW]}/g" \
  -e "s/border-color=#${PRIMARY[$OLD]}/border-color=#${PRIMARY[$NEW]}/g" \
  -e "s/border-color=#${GREEN[$OLD]}/border-color=#${GREEN[$NEW]}/g" \
  -e "s/border-color=#${RED[$OLD]}/border-color=#${RED[$NEW]}/g" \
  -e "s/border-color=#${ACCENT[$OLD]}/border-color=#${ACCENT[$NEW]}/g" \
  -e "s/border-color=#${PURPLE[$OLD]}/border-color=#${PURPLE[$NEW]}/g" \
  -e "s/progress-color=over #${GREEN[$OLD]}/progress-color=over #${GREEN[$NEW]}/g" \
  ~/.config/mako/config

# fuzzel/fuzzel.ini
sed -i \
  -e "s/background=${BG[$OLD]}e6/background=${BG[$NEW]}e6/g" \
  -e "s/\(selection-text\|text\)=${FG[$OLD]}ff/\1=${FG[$NEW]}ff/g" \
  -e "s/match=${PRIMARY[$OLD]}ff/match=${PRIMARY[$NEW]}ff/g" \
  -e "s/selection=${FUZZEL_SEL[$OLD]}/selection=${FUZZEL_SEL[$NEW]}/g" \
  -e "s/selection-match=${GREEN[$OLD]}ff/selection-match=${GREEN[$NEW]}ff/g" \
  -e "s/border=${PRIMARY[$OLD]}ff/border=${PRIMARY[$NEW]}ff/g" \
  ~/.config/fuzzel/fuzzel.ini

# ghostty/config
sed -i \
  "s/^theme = ${GHOSTTY_THEME[$OLD]}$/theme = ${GHOSTTY_THEME[$NEW]}/" \
  ~/.config/ghostty/config

# hyprlock.conf — decimal rgb triplets + comment hex in span
sed -i \
  -e "s/${ACCENT_RGB[$OLD]}/${ACCENT_RGB[$NEW]}/g" \
  -e "s/${FG_RGB[$OLD]}/${FG_RGB[$NEW]}/g" \
  -e "s/${PRIMARY_RGB[$OLD]}/${PRIMARY_RGB[$NEW]}/g" \
  -e "s/${BG_RGB[$OLD]}/${BG_RGB[$NEW]}/g" \
  -e "s/${COMMENT_RGB[$OLD]}/${COMMENT_RGB[$NEW]}/g" \
  -e "s/${RED_RGB[$OLD]}/${RED_RGB[$NEW]}/g" \
  -e "s/##${COMMENT[$OLD]}/##${COMMENT[$NEW]}/g" \
  ~/.config/hypr/hyprlock.conf

# hyprpaper.conf — swap wallpaper filename
if [[ "${WALLPAPER[$OLD]}" != "${WALLPAPER[$NEW]}" ]]; then
  sed -i \
    "s/${WALLPAPER[$OLD]}/${WALLPAPER[$NEW]}/g" \
    ~/.config/hypr/hyprpaper.conf
fi

# ─── Save current theme ───────────────────────────────────────────────────────

echo "$NEW" >"$CURRENT_THEME_FILE"

# ─── Reload services ─────────────────────────────────────────────────────────

hyprctl reload
pkill -SIGUSR2 waybar
pkill -SIGUSR2 ghostty
makoctl reload
killall hyprpaper 2>/dev/null
sleep 0.3
hyprpaper &
