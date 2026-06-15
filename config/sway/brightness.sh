#!/bin/sh
set -eu

device="${BRIGHTNESS_DEVICE:-backlight@0}"

case "${1:-}" in
    up)
        change="1+"
        ;;
    down)
        change="1-"
        ;;
    *)
        notify-send "Brightness" "Use: brightness.sh up|down" || true
        exit 2
        ;;
esac

if ! error="$(brightnessctl -d "$device" set "$change" 2>&1 >/dev/null)"; then
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
