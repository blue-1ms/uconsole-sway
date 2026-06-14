#!/bin/sh

choice="$(printf '%s\n' \
  '  Lock' \
  '  Reload Sway' \
  '  Exit Sway' \
  '  Reboot' \
  '  Power off' | wofi --show dmenu --prompt Power --width 70% --height 55% --gtk-dark)"

case "$choice" in
  *'Lock')
    /home/mew/.config/sway/lock.sh
    ;;
  *'Reload Sway')
    swaymsg reload
    ;;
  *'Exit Sway')
    swaymsg exit
    ;;
  *'Reboot')
    systemctl reboot
    ;;
  *'Power off')
    systemctl poweroff
    ;;
esac
