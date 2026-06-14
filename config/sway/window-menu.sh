#!/bin/sh
set -eu

mode="${1:-focus}"
prompt="Open windows"

if [ "$mode" = "kill" ]; then
    prompt="Close window"
fi

windows="$(swaymsg -t get_tree | jq -r '
  recurse(.nodes[]?, .floating_nodes[]?)
  | select(.type == "con" and .name != null and ((.app_id? // .window_properties?.class?) != null))
  | "\(.id)\t\((.app_id // .window_properties.class // "app"))\t\(.name)"
')"

if [ -z "$windows" ]; then
    notify-send "Windows" "No open windows found"
    exit 0
fi

choice="$(
    printf '%s\n' "$windows" |
    awk -F '\t' '{ print $2 " - " $3 " [" $1 "]" }' |
    wofi --show dmenu --prompt "$prompt" --width 90% --height 75% --gtk-dark
)"

id="$(printf '%s' "$choice" | sed -n 's/.*\[\([0-9][0-9]*\)\]$/\1/p')"

if [ -z "$id" ]; then
    exit 0
fi

if [ "$mode" = "kill" ]; then
    swaymsg "[con_id=$id]" kill
else
    swaymsg "[con_id=$id]" focus
fi
