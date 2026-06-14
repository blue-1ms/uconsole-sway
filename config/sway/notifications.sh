#!/bin/sh
set -eu

if command -v swaync-client >/dev/null 2>&1; then
    exec swaync-client -t -sw
fi

notify-send "Notification center" "Install with: sudo apt install sway-notification-center"
