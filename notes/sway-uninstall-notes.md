# Sway Uninstall Notes

Created: 2026-06-13
Last updated: 2026-06-14

Use this if Sway is installed alongside GNOME and you decide you do not want Sway anymore.

## Safe Order

1. Log out of Sway.
2. At the login screen, choose the Ubuntu/GNOME session from the gear/session menu.
3. Log into GNOME and confirm the desktop works normally.
4. Remove only the Sway-related packages.

Do not remove these unless you specifically know why:

```bash
gdm3
gnome-shell
ubuntu-desktop
ubuntu-session
```

## Remove Sway Packages

If Sway was installed with the package set we discussed, remove those packages with:

```bash
sudo apt remove sway swaybg swayidle swaylock waybar wofi foot mako-notifier grim grimshot slurp wl-clipboard xdg-desktop-portal-wlr pavucontrol blueman wdisplays gammastep cliphist wlogout fonts-font-awesome sway-notification-center udiskie thunar tumbler mousepad mpv mpv-mpris playerctl evtest evemu-tools
```

`apt remove` removes the installed packages but usually leaves package-managed configuration behind. This is a safer first step than purging everything.

Some later polish apps are useful outside Sway too. If you use Thunar, Mousepad, mpv, or playerctl in GNOME, omit those package names from the remove command.

Then clean unused dependencies, but read the package list before confirming:

```bash
sudo apt autoremove
```

If `autoremove` wants to remove GNOME, Ubuntu desktop, display-manager, network, audio, or driver packages, stop and do not confirm.

If optional theme/polish packages were installed later, remove them separately with:

```bash
sudo apt remove lxappearance qt5ct qt6ct arc-theme papirus-icon-theme materia-gtk-theme
```

## Optional Purge

If you are sure you do not want leftover package configuration for those packages:

```bash
sudo apt purge sway swaybg swayidle swaylock waybar wofi foot mako-notifier grim grimshot slurp wl-clipboard xdg-desktop-portal-wlr pavucontrol blueman wdisplays gammastep cliphist wlogout fonts-font-awesome sway-notification-center udiskie thunar tumbler mousepad mpv mpv-mpris playerctl evtest evemu-tools
sudo apt autoremove --purge
```

Purge does not remove your personal files in your home directory.

## Optional User Config Cleanup

Your personal Sway config lives under `~/.config`. Back it up first:

```bash
mkdir -p ~/old-sway-config
mv ~/.config/sway ~/old-sway-config/ 2>/dev/null
mv ~/.config/waybar ~/old-sway-config/ 2>/dev/null
mv ~/.config/wofi ~/old-sway-config/ 2>/dev/null
mv ~/.config/foot ~/old-sway-config/ 2>/dev/null
mv ~/.config/mako ~/old-sway-config/ 2>/dev/null
mv ~/.config/wlogout ~/old-sway-config/ 2>/dev/null
mv ~/.config/gammastep ~/old-sway-config/ 2>/dev/null
mv ~/.config/swaync ~/old-sway-config/ 2>/dev/null
```

Clipboard history from `cliphist` may live under cache/state directories. If you want to back it up or remove it later, check:

```bash
find ~/.cache ~/.local/state -maxdepth 2 -iname '*cliphist*' -print 2>/dev/null
```

After a few days, if everything is fine and you do not need the backup, delete `~/old-sway-config`.

## Check That Sway Is Gone

After logging back into GNOME:

```bash
ps -e | grep -E 'sway|waybar|wlogout|gammastep|blueman-applet|gnome-shell|mutter|gdm'
```

Expected:

- `gnome-shell`, `mutter`, and possibly `gdm` while in GNOME.
- No `sway`, `waybar`, `wlogout`, `gammastep`, or `blueman-applet` unless you started them manually.

## Reinstall Later

If you change your mind:

```bash
sudo apt update
sudo apt install sway swaybg swayidle swaylock waybar wofi foot mako-notifier grim grimshot slurp wl-clipboard xdg-desktop-portal-wlr pavucontrol blueman wdisplays gammastep cliphist wlogout fonts-font-awesome sway-notification-center udiskie thunar tumbler mousepad mpv mpv-mpris playerctl evtest evemu-tools
```

Then log out and choose Sway again from the login screen session menu.

## References

- Ubuntu `apt` manpage: https://manpages.ubuntu.com/manpages/noble/man8/apt.8.html
- Ubuntu `apt-get` manpage: https://manpages.ubuntu.com/manpages/noble/man8/apt-get.8.html
- Ubuntu `sway` package page: https://packages.ubuntu.com/noble/sway
