#!/bin/sh
set -eu

themes='Yaru Viridian Dark|Yaru-viridian-dark|Yaru-viridian|prefer-dark
Yaru Blue Dark|Yaru-blue-dark|Yaru-blue|prefer-dark
Yaru Purple Dark|Yaru-purple-dark|Yaru-purple|prefer-dark
Yaru Sage Dark|Yaru-sage-dark|Yaru-sage|prefer-dark
Yaru Red Dark|Yaru-red-dark|Yaru-red|prefer-dark
Yaru Bark Dark|Yaru-bark-dark|Yaru-bark|prefer-dark
Yaru Dark|Yaru-dark|Yaru-dark|prefer-dark
Adwaita Dark|Adwaita-dark|Adwaita|prefer-dark
Yaru Light|Yaru|Yaru|prefer-light
Adwaita Light|Adwaita|Adwaita|prefer-light'

add_theme() {
    label="$1"
    gtk="$2"
    icons="$3"
    scheme="$4"

    [ -d "/usr/share/themes/$gtk" ] || return 0
    [ -d "/usr/share/icons/$icons" ] || return 0
    themes="$themes
$label|$gtk|$icons|$scheme"
}

add_theme 'Arc Dark + Papirus' 'Arc-Dark' 'Papirus-Dark' 'prefer-dark'
add_theme 'Arc Darker + Papirus' 'Arc-Darker' 'Papirus-Dark' 'prefer-dark'
add_theme 'Materia Dark + Papirus' 'Materia-dark' 'Papirus-Dark' 'prefer-dark'
add_theme 'Materia + Papirus' 'Materia' 'Papirus' 'prefer-light'
add_theme 'Numix + Numix icons' 'Numix' 'Numix' 'prefer-light'

choice="$(
    printf '%s\n' "$themes" |
    awk -F '|' '{print $1}' |
    wofi --show dmenu --prompt "Theme" --width 88% --height 82% --gtk-dark
)"

[ -n "$choice" ] || exit 0

line="$(printf '%s\n' "$themes" | awk -F '|' -v choice="$choice" '$1 == choice {print; exit}')"

if [ -z "$line" ]; then
    exit 0
fi

mkdir -p "$HOME/.config/sway"
printf '%s\n' "$line" > "$HOME/.config/sway/theme-current"
"$HOME/.config/sway/theme-apply.sh" --notify
