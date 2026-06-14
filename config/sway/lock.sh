#!/bin/sh
set -eu

config="$HOME/.config/sway/config"
fallback="/usr/share/backgrounds/Numbat_wallpaper_dimmed_3480x2160.png"

wallpaper="$(
    awk '
        /^[[:space:]]*output[[:space:]]+\*[[:space:]]+bg[[:space:]]+/ {
            line = $0
            sub(/^[[:space:]]*output[[:space:]]+\*[[:space:]]+bg[[:space:]]+/, "", line)
            sub(/[[:space:]]+(fill|fit|stretch|center|tile|solid_color)[[:space:]]*$/, "", line)
            gsub(/^"/, "", line)
            gsub(/"$/, "", line)
            print line
            exit
        }
    ' "$config"
)"

if [ -z "$wallpaper" ] || [ ! -f "$wallpaper" ]; then
    wallpaper="$fallback"
fi

exec swaylock -f \
    --ignore-empty-password \
    --show-failed-attempts \
    --indicator-idle-visible \
    --image "$wallpaper" \
    --scaling fill \
    --color 101418 \
    --font "Ubuntu Sans" \
    --font-size 18 \
    --indicator-radius 70 \
    --indicator-thickness 10 \
    --inside-color 101418cc \
    --inside-clear-color 101418cc \
    --inside-ver-color 2c7a72cc \
    --inside-wrong-color 8f2432cc \
    --ring-color 2b333bcc \
    --ring-clear-color 2b333bcc \
    --ring-ver-color 67d1c8ff \
    --ring-wrong-color ff7b86ff \
    --line-color 101418cc \
    --separator-color 101418ff \
    --text-color f2f4f5ff \
    --text-clear-color f2f4f5ff \
    --text-ver-color f2f4f5ff \
    --text-wrong-color f2f4f5ff \
    --key-hl-color 87d99bff \
    --bs-hl-color ff7b86ff \
    --layout-bg-color 101418cc \
    --layout-border-color 2c7a72ff \
    --layout-text-color f2f4f5ff
