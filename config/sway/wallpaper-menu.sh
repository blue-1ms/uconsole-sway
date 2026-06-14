#!/bin/sh
set -eu

config="$HOME/.config/sway/config"

wallpapers="$(
    for dir in /usr/share/backgrounds "$HOME/Pictures"; do
        [ -d "$dir" ] || continue
        find "$dir" -type f \
            \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \)
    done 2>/dev/null | sort
)"

if [ -z "$wallpapers" ]; then
    notify-send "Wallpaper" "No images found in /usr/share/backgrounds or ~/Pictures"
    exit 0
fi

choice="$(
    printf '%s\n' "$wallpapers" |
    wofi --show dmenu --prompt "Wallpaper" --width 95% --height 75% --gtk-dark
)"

if [ -z "$choice" ]; then
    exit 0
fi

if [ ! -f "$choice" ]; then
    notify-send "Wallpaper" "Selected file does not exist"
    exit 1
fi

escaped="$(printf '%s' "$choice" | sed 's/[\\"]/\\&/g')"
swaymsg "output * bg \"$escaped\" fill"

tmp="$(mktemp "$config.XXXXXX")"
trap 'rm -f "$tmp"' EXIT

awk -v wallpaper="$choice" '
function quote(s, t) {
    t = s
    gsub(/\\/, "\\\\", t)
    gsub(/"/, "\\\"", t)
    return "\"" t "\""
}

BEGIN {
    done = 0
}

/^[[:space:]]*output[[:space:]]+\*[[:space:]]+bg[[:space:]]+/ && !done {
    print "output * bg " quote(wallpaper) " fill"
    done = 1
    next
}

{
    print
}

END {
    if (!done) {
        print "output * bg " quote(wallpaper) " fill"
    }
}
' "$config" > "$tmp"

mv "$tmp" "$config"
trap - EXIT

notify-send "Wallpaper updated" "$(basename "$choice")"
