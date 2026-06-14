#!/bin/sh
set -eu

state_dir="${XDG_RUNTIME_DIR:-/tmp}/uconsole-power-key"
armed_file="$state_dir/armed"
long_file="$state_dir/long-press"
timer_pid_file="$state_dir/timer.pid"
hold_seconds="${POWER_KEY_HOLD_SECONDS:-2}"
power_menu="/home/mew/.config/sway/power-menu.sh"

mkdir -p "$state_dir"

stop_timer() {
    if [ -s "$timer_pid_file" ]; then
        kill "$(cat "$timer_pid_file")" 2>/dev/null || true
    fi
    rm -f "$timer_pid_file"
}

case "${1:-}" in
    press)
        [ -e "$armed_file" ] && exit 0
        rm -f "$long_file"
        : > "$armed_file"
        (
            sleep "$hold_seconds"
            if [ -e "$armed_file" ]; then
                rm -f "$armed_file"
                : > "$long_file"
                systemctl poweroff
            fi
        ) &
        printf '%s\n' "$!" > "$timer_pid_file"
        ;;
    release)
        if [ -e "$armed_file" ]; then
            stop_timer
            rm -f "$armed_file" "$long_file"
            exec "$power_menu"
        fi
        rm -f "$long_file"
        stop_timer
        ;;
    *)
        printf '%s\n' "usage: $0 press|release" >&2
        exit 2
        ;;
esac
