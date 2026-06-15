#!/bin/sh
set -eu

title="sway-scratchpad-terminal"

if swaymsg -t get_tree | jq -e '.. | objects | select(.name? == "sway-scratchpad-terminal")' >/dev/null 2>&1; then
    exec swaymsg '[title="sway-scratchpad-terminal"] scratchpad show'
fi

exec /home/mew/.config/sway/terminal.sh --title="$title"
