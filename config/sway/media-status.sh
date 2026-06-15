#!/bin/sh
set -eu

if ! command -v playerctl >/dev/null 2>&1; then
    jq -cn --arg text "" --arg tooltip "playerctl not installed" --arg class "stopped" \
        '{text: $text, tooltip: $tooltip, class: $class}'
    exit 0
fi

status="$(playerctl status 2>/dev/null || true)"
max_chars="${MEDIA_STATUS_MAX_CHARS:-44}"
stale_after="${MEDIA_STATUS_STALE_AFTER:-600}"
state_dir="${MEDIA_STATUS_STATE_DIR:-${XDG_RUNTIME_DIR:-$HOME/.cache}/sway}"
last_playing_file="$state_dir/media-last-playing"
now="$(date +%s)"

case "$status" in
    Playing)
        icon=""
        class="playing"
        show_track=1
        mkdir -p "$state_dir"
        printf '%s\n' "$now" > "$last_playing_file"
        ;;
    Paused)
        icon=""
        class="paused"
        show_track=0
        if [ -r "$last_playing_file" ]; then
            last_playing="$(sed -n '1p' "$last_playing_file")"
            case "$last_playing" in
                *[!0-9]*|"")
                    ;;
                *)
                    age=$((now - last_playing))
                    if [ "$age" -le "$stale_after" ]; then
                        show_track=1
                    fi
                    ;;
            esac
        fi
        ;;
    *)
        jq -cn --arg text "" --arg tooltip "No active media player" --arg class "stopped" \
            '{text: $text, tooltip: $tooltip, class: $class}'
        exit 0
        ;;
esac

artist=""
title=""
track=""
tooltip_track=""
if [ "$show_track" -eq 1 ]; then
    artist="$(playerctl metadata artist 2>/dev/null | sed -n '1p' || true)"
    title="$(playerctl metadata title 2>/dev/null | sed -n '1p' || true)"

    if [ -n "$title" ] && [ -n "$artist" ]; then
        track="$artist - $title"
        tooltip_track="$track"
    elif [ -n "$title" ]; then
        track="$title"
        tooltip_track="$title"
    elif [ -n "$artist" ]; then
        track="$artist"
        tooltip_track="$artist"
    fi
fi

if [ -n "$track" ]; then
    text="$icon $track"
    tooltip="$status: ${tooltip_track:-$track}"
else
    text="$icon"
    tooltip="$status"
fi

text_chars="$(printf '%s' "$text" | wc -m | tr -d ' ')"
if [ "$text_chars" -gt "$max_chars" ]; then
    cut_chars=$((max_chars - 3))
    text="$(printf '%s' "$text" | cut -c "1-${cut_chars}")..."
fi

jq -cn --arg text "$text" --arg tooltip "$tooltip" --arg class "$class" \
    '{text: $text, tooltip: $tooltip, class: $class}'
