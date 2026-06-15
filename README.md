# uConsole Sway

Polished Sway configuration for the ClockworkPi uConsole on Ubuntu, tuned for the 5 inch display while keeping GNOME installed as a fallback session. This setup was built on top of the uConsole Ubuntu image shared by Rex on the ClockworkPi forum.

## What Is Included

- Sway config with 1.0 output scale, larger terminal text, larger Wofi launcher, and compact workspace labels.
- Waybar setup with integrated resource status, dynamic battery state, brightness, audio, clock, and tray modules.
- Sway Notification Center styling flattened to avoid nested notification boxes.
- Foot terminal, Wofi launcher/run prompt, compact Wofi power menu, physical power-key handler, wallpaper picker, theme switcher, lock screen, clipboard picker, scratchpad terminal, brightness/volume helpers, Waybar media status, and window picker scripts.
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
- `Super+grave`: scratchpad terminal
- `Super+Space` or `Super+d`: app launcher
- `Super+Shift+Space`: run prompt
- `Super+Tab`: window picker
- `Super+Shift+Tab`: choose a window to close
- `Super+/`: fullscreen shortcut sheet
- `Super+n`: notification center
- `Super+Control+l`: lock screen
- `Super+Shift+p`: power menu
- `Super+Shift+r`: Shairport TUI
- `Super+Shift+t`: theme switcher
- `Super+Shift+w`: wallpaper picker
- `Super+Shift+c`: reload Sway
- Physical power button: tap for power menu, hold 2s to shut down

See [notes/sway-setup-notes.md](notes/sway-setup-notes.md) for the full setup history and [notes/sway-uninstall-notes.md](notes/sway-uninstall-notes.md) for removal steps.

## Device Notes

- The config intentionally uses `output * scale 1.0`; app and terminal readability are handled through font and UI sizing.
- Foot launches standalone terminals with `term=foot`; the terminal wrapper disables Codex keyboard enhancement to avoid duplicate key behavior.
- Brightness uses `config/sway/brightness.sh` because the uConsole panel exposes only a small number of hardware brightness levels.
- Volume up is capped at 100% for both hardware volume keys and Waybar scroll.
- Waybar uses the simpler Option B status icon set: cogs for CPU, database for memory, adjust for brightness, and softer volume plus the supported mute glyph. The bar keeps status spacing tight and hides the notification-center and power-menu buttons; use `Super+n` for notifications and `Super+Shift+p` for power actions.
- Sway Notification Center opens with `Super+n`, without a Waybar icon, and its panel is flush with the top edge.
- Wofi keeps app icons visible and uses its cache so frequent apps appear first.
- Waybar includes adaptive playerctl media status: playing, paused, and stopped have distinct icons; artist-first track text is bounded to 44 characters by default and expires after 10 minutes without active playback.
- Hardware and Waybar volume controls use `config/sway/volume.sh` for capped volume-up behavior and notification feedback.
- `Super+Shift+Space` opens the Wofi run prompt; floating toggle is `Super+Control+f`.
- `Super+grave` toggles a floating scratchpad Foot terminal.
- Workspace 6 is the music workspace, labeled `6 ` in Sway and Waybar.
- `Super+Shift+r` opens `/home/mew/bin/shairport-tui` in a fullscreen Foot terminal on the current workspace.
- Gammastep remains installed and can be toggled with `Super+Shift+g`, but it no longer autostarts because this display path currently reports no gamma adjustment support.
- Optional Arc/Materia/Papirus themes are available in the switcher when installed. Choosing them may make `snapd-desktop-integration` warn about missing theme snaps; switch to Yaru/Adwaita if you want a quiet login.
- Suspend is not exposed in the power menu because this device currently has wake issues after suspend/black-screen behavior. The physical power key is configured so logind ignores short presses and Sway handles tap versus hold through `power-key.sh`.

## Credits

- Rex on the ClockworkPi forum for the uConsole Ubuntu image this setup builds on.
