#!/bin/sh
set -eu

state="$HOME/.config/sway/theme-current"
label="Yaru Viridian Dark"
gtk="Yaru-viridian-dark"
icons="Yaru-viridian"
scheme="prefer-dark"

if [ -r "$state" ]; then
    IFS='|' read -r label gtk icons scheme < "$state"
fi

if ! {
    gsettings set org.gnome.desktop.interface color-scheme "$scheme" &&
    gsettings set org.gnome.desktop.interface gtk-theme "$gtk" &&
    gsettings set org.gnome.desktop.interface icon-theme "$icons" &&
    gsettings set org.gnome.desktop.interface font-name 'Ubuntu Sans 11' &&
    gsettings set org.gnome.desktop.interface document-font-name 'Ubuntu Sans 11' &&
    gsettings set org.gnome.desktop.interface monospace-font-name 'Ubuntu Sans Mono 13' &&
    gsettings set org.gnome.desktop.interface text-scaling-factor 1.0 &&
    gsettings set org.gnome.desktop.interface cursor-size 32
}; then
    notify-send "Theme failed" "Could not write GNOME interface settings"
    exit 1
fi

if [ "${1:-}" = "--notify" ]; then
    notify-send "Theme applied" "$label"
fi
