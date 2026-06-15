#!/bin/sh
set -eu

interval="${MEDIA_STATUS_LOOP_INTERVAL:-1}"

while :; do
    /home/mew/.config/sway/media-status.sh
    sleep "$interval"
done
