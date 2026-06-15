#!/bin/sh
set -eu

target="@DEFAULT_AUDIO_SINK@"
title="Volume"

case "${1:-}" in
    up)
        wpctl set-volume -l 1.0 "$target" 5%+
        ;;
    down)
        wpctl set-volume "$target" 5%-
        ;;
    mute)
        wpctl set-mute "$target" toggle
        ;;
    mic-mute)
        target="@DEFAULT_AUDIO_SOURCE@"
        title="Microphone"
        wpctl set-mute "$target" toggle
        ;;
    *)
        notify-send "$title" "Use: volume.sh up|down|mute|mic-mute" || true
        exit 2
        ;;
esac

state="$(wpctl get-volume "$target" 2>/dev/null || true)"
percent="$(printf '%s\n' "$state" | awk '{printf "%d%%", ($2 * 100) + 0.5}')"

case "$state" in
    *"[MUTED]"*)
        message="Muted"
        ;;
    *)
        message="$percent"
        ;;
esac

notify-send -h "string:x-canonical-private-synchronous:${title}" "$title" "$message" || true
