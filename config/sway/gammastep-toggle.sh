#!/bin/sh

command -v gammastep >/dev/null 2>&1 || exit 0

if pgrep -x gammastep >/dev/null; then
  pkill -x gammastep
  gammastep -x >/dev/null 2>&1 || true
  notify-send "Night color" "Off"
else
  gammastep >/tmp/gammastep-sway.log 2>&1 &
  notify-send "Night color" "On"
fi
