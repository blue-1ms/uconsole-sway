#!/bin/sh
set -eu

device="${BRIGHTNESS_DEVICE:-backlight@0}"

choice="$(printf '%s\n' \
    '10%' \
    '25%' \
    '40%' \
    '55%' \
    '70%' \
    '85%' \
    '100%' | wofi --show dmenu --prompt Brightness --width 55% --height 45% --gtk-dark || true)"

case "$choice" in
    10%|25%|40%|55%|70%|85%|100%)
        ;;
    *)
        exit 0
        ;;
esac

if ! error="$(brightnessctl -d "$device" set "$choice" 2>&1 >/dev/null)"; then
    case "$error" in
        *"Permission denied"*|*"root privileges"*)
            notify-send "Brightness permission needed" "Run: sudo usermod -aG video mew" || true
            ;;
        *)
            notify-send "Brightness" "Could not change $device" || true
            ;;
    esac
    exit 1
fi

percent="$(brightnessctl -d "$device" -m info | awk -F, '{print $4}')"
notify-send -h string:x-canonical-private-synchronous:brightness "Brightness" "$percent" || true
