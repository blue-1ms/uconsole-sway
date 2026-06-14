# uConsole Sway

Polished Sway configuration for the ClockworkPi uConsole on Ubuntu, tuned for the 5 inch display while keeping GNOME installed as a fallback session. This setup was built on top of the uConsole Ubuntu image shared by Rex on the ClockworkPi forum.

## What Is Included

- Sway config with 1.0 output scale, larger terminal text, larger Wofi launcher, and compact workspace labels.
- Waybar setup with integrated resource status, dynamic battery state, notification center, brightness, audio, clock, power, and tray modules.
- Sway Notification Center styling flattened to avoid nested notification boxes.
- Foot terminal, Wofi launcher, compact Wofi power menu, wallpaper picker, theme switcher, lock screen, clipboard picker, brightness helper, and window picker scripts.
- GTK, Gammastep, Mako fallback, Wlogout legacy files, and setup/uninstall notes.

## Layout

```text
config/
  foot/
  gammastep/
  gtk-3.0/
  gtk-4.0/
  mako/
  sway/
  swaync/
  waybar/
  wlogout/
  wofi/
notes/
  sway-setup-notes.md
  sway-uninstall-notes.md
```

## Install Packages

```bash
sudo apt install sway swaybg swayidle swaylock waybar wofi foot mako-notifier grim grimshot slurp wl-clipboard xdg-desktop-portal-wlr pavucontrol blueman wdisplays gammastep cliphist wlogout fonts-font-awesome sway-notification-center udiskie thunar tumbler mousepad mpv mpv-mpris playerctl evtest evemu-tools
```

Optional theme tools:

```bash
sudo apt install lxappearance qt5ct qt6ct arc-theme papirus-icon-theme materia-gtk-theme
```

## Apply Config

Back up existing config first:

```bash
mkdir -p ~/old-sway-config
mv ~/.config/sway ~/.config/waybar ~/.config/wofi ~/.config/foot ~/.config/swaync ~/.config/mako ~/.config/wlogout ~/.config/gammastep ~/old-sway-config/ 2>/dev/null
```

Copy the repo config into place:

```bash
cp -a config/sway ~/.config/
cp -a config/waybar ~/.config/
cp -a config/wofi ~/.config/
cp -a config/foot ~/.config/
cp -a config/swaync ~/.config/
cp -a config/mako ~/.config/
cp -a config/wlogout ~/.config/
cp -a config/gammastep ~/.config/
mkdir -p ~/.config/gtk-3.0 ~/.config/gtk-4.0
cp -a config/gtk-3.0/settings.ini ~/.config/gtk-3.0/settings.ini
cp -a config/gtk-4.0/settings.ini ~/.config/gtk-4.0/settings.ini
```

Log out and choose the Sway session from the login screen.

## Main Shortcuts

- `Super+Enter`: terminal
- `Super+Shift+Enter`: fullscreen terminal
- `Super+Space` or `Super+d`: app launcher
- `Super+Tab`: window picker
- `Super+Shift+Tab`: choose a window to close
- `Super+/`: fullscreen shortcut sheet
- `Super+n`: notification center
- `Super+Control+l`: lock screen
- `Super+Shift+p`: power menu
- `Super+Shift+t`: theme switcher
- `Super+Shift+w`: wallpaper picker
- `Super+Shift+c`: reload Sway

See [notes/sway-setup-notes.md](notes/sway-setup-notes.md) for the full setup history and [notes/sway-uninstall-notes.md](notes/sway-uninstall-notes.md) for removal steps.

## Device Notes

- The config intentionally uses `output * scale 1.0`; app and terminal readability are handled through font and UI sizing.
- Brightness uses `config/sway/brightness.sh` because the uConsole panel exposes only a small number of hardware brightness levels.
- Suspend is not exposed in the power menu because this device currently has wake issues after suspend/black-screen behavior.

## Credits

- Rex on the ClockworkPi forum for the uConsole Ubuntu image this setup builds on.
