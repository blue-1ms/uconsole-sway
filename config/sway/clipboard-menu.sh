#!/bin/sh

command -v cliphist >/dev/null 2>&1 || exit 0
command -v wofi >/dev/null 2>&1 || exit 0
command -v wl-copy >/dev/null 2>&1 || exit 0

selection="$(cliphist list | wofi --show dmenu --prompt Clipboard --width 85% --height 75% --gtk-dark)"
[ -n "$selection" ] || exit 0

printf '%s' "$selection" | cliphist decode | wl-copy
notify-send "Clipboard" "Selected item copied"
