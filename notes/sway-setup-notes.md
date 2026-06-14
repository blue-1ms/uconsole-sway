# Sway Setup Notes

Created: 2026-06-13
Last updated: 2026-06-14

This Sway setup is installed alongside GNOME. Choose Sway from the login screen gear/session menu.

## Config Files

- Sway: `~/.config/sway/config`
- Shortcut sheet: `~/.config/sway/shortcuts.txt`
- Waybar: `~/.config/waybar/config`
- Waybar style: `~/.config/waybar/style.css`
- Wofi launcher: `~/.config/wofi/config`
- Wofi style: `~/.config/wofi/style.css`
- Foot terminal: `~/.config/foot/foot.ini`
- Mako notifications: `~/.config/mako/config`
- Sway Notification Center: `~/.config/swaync/config.json` and `~/.config/swaync/style.css`
- GTK dark mode: `~/.config/gtk-3.0/settings.ini` and `~/.config/gtk-4.0/settings.ini`
- Wlogout power menu: `~/.config/wlogout/layout` and `~/.config/wlogout/style.css`
- Gammastep night color: `~/.config/gammastep/config.ini`
- Helper scripts: `~/.config/sway/terminal.sh`, `~/.config/sway/power-menu.sh`, `~/.config/sway/clipboard-menu.sh`, `~/.config/sway/gammastep-toggle.sh`, `~/.config/sway/window-menu.sh`, `~/.config/sway/wallpaper-menu.sh`, `~/.config/sway/brightness.sh`, `~/.config/sway/theme-menu.sh`, `~/.config/sway/theme-apply.sh`, `~/.config/sway/lock.sh`, `~/.config/sway/notifications.sh`

## First Login

The bar should appear at the top with:

- Workspaces and focused window title
- CPU, memory, battery, brightness when available, volume, notifications, clock, power menu, and tray
- No taskbar launcher icon, network module, or shortcut-help icon; those remain available by keyboard shortcut

Key starting points:

- `Super+Enter`: terminal
- `Super+Shift+Enter`: fullscreen terminal
- `Super+Space`: app launcher
- `Super+d`: app launcher too
- `Super+Tab`: show open windows and switch to one
- `Super+Shift+Tab`: show open windows and close selected one
- `Super+/`: shortcut sheet
- `Super+n`: notification center
- `Super+Control+l`: lock screen
- `Super+Shift+x`: system monitor
- `Super+Escape`: force-kill clicked window
- `Super+c`: clipboard history picker
- `Super+Shift+v`: Mousepad text editor
- `Super+Shift+p`: power menu
- `Super+Control+Up`: increase screen brightness
- `Super+Control+Down`: decrease screen brightness
- `Super+Shift+a`: pavucontrol audio mixer
- `Super+Shift+o`: Bluetooth manager
- `Super+Shift+d`: display settings
- `Super+Shift+g`: toggle night color
- `Super+Shift+t`: theme switcher
- `Super+Shift+w`: wallpaper picker
- `Super+Shift+c`: reload config
- `Super+Shift+e`: exit Sway

The bar uses FontAwesome icons for CPU, memory, battery, brightness, volume, notifications, and power. The app launcher shortcut is `Super+Space` or `Super+d`; there is intentionally no launcher button on the bar. Network settings remain available with `Super+Shift+n`, and volume opens `pavucontrol` when clicked.

## Workspaces

- Workspaces 1..5 are predefined with compact FontAwesome labels: `1 ` terminal, `2 ` browser, `3 ` files, `4 ` mail, and `5 ` tools.
- `Super+1..5` switches to those named workspaces; `Super+Shift+1..5` moves the focused window there.
- Workspaces 6..10 remain plain numeric overflow workspaces.
- Apps are not automatically forced onto these workspaces; the labels are organizational hints only.

## Wallpaper And Theme

- Wallpaper picker: `Super+Shift+w`. It scans `/usr/share/backgrounds` and `~/Pictures`, applies the selected image with `swaymsg`, then rewrites the `output * bg ... fill` line in `~/.config/sway/config` so the wallpaper persists.
- Manual wallpaper line: `output * bg "path/to/image" fill` in `~/.config/sway/config`.
- GTK/app theme is applied by `~/.config/sway/theme-apply.sh` from the saved choice in `~/.config/sway/theme-current`.
- Theme switcher: `Super+Shift+t`. It uses `~/.config/sway/theme-menu.sh`, stores the selected theme in `~/.config/sway/theme-current`, and applies it through `~/.config/sway/theme-apply.sh` so the choice survives Sway reloads. External GNOME Appearance/LXAppearance launcher entries remain removed, but third-party Arc/Materia/Papirus/Numix choices are available again when installed. Choosing them can trigger Snap's harmless "missing theme snaps" warning because Snap apps try to find matching theme snaps.
- Optional richer theme tools and themes can be installed from a real terminal if needed: `sudo apt install lxappearance qt5ct qt6ct arc-theme papirus-icon-theme materia-gtk-theme`.
- Top bar theme: `~/.config/waybar/style.css`.
- App launcher theme: `~/.config/wofi/style.css`.
- Power menu theme: compact Wofi menu through `~/.config/sway/power-menu.sh`, using `~/.config/wofi/style.css`.
- Installed GUI helpers referenced by shortcuts: `thunar` for files, `mousepad` for text editing, `wdisplays` for display layout, `pavucontrol` for audio, `blueman-manager` for Bluetooth, and `gnome-control-center` for GNOME settings panels that still work under Sway.

## Display Scale

The config currently uses:

```text
output * scale 1.0
```

Foot is configured separately with exact pixel-sized terminal text:

```text
font=Ubuntu Sans Mono:pixelsize=22
```

This lets the terminal follow Sway's output scale. You can also tune terminal text live:

- `Ctrl++`: bigger terminal font
- `Ctrl+-`: smaller terminal font
- `Ctrl+0`: reset terminal font

If apps look blurry, especially older XWayland apps, change output scale to:

```text
output * scale 1
```

Then increase font sizes in the Sway, Waybar, Wofi, and Foot config files instead.

## Current Optimization State

- Output scale is intentionally `1.0` because the desktop GUI looked acceptable without scaling.
- Terminal readability is handled in Foot with `font=Ubuntu Sans Mono:pixelsize=22`.
- Foot uses a high-contrast teal beam cursor: `color=101418 9ee7df` and `beam-thickness=3px`.
- Foot server mode is started by Sway; the terminal wrapper uses `footclient` and falls back to `foot`.
- Keyboard repeat is slowed for the uConsole keyboard with `repeat_delay 850` and `repeat_rate 10`. Backspace double-delete was later found to happen only in Codex, not in the terminal, so Sway repeat was restored from the temporary disabled setting.
- If duplicate key events happen outside Codex, diagnose hardware key bounce with `wev` under Sway. Optional packages available for deeper keyboard diagnostics/filtering include `evtest`, `evemu-tools`, `input-remapper`, and `interception-tools`.
- Brightness uses `~/.config/sway/brightness.sh` with device `backlight@0` and one hardware step per press. The panel exposes only 9 levels, so percentage steps like `5%+` can be too small to work visibly. Shortcuts are `Super+Control+Up` and `Super+Control+Down`; hardware brightness keys and Waybar brightness scrolling call the same helper.
- If brightness still cannot be changed from inside Sway, check permissions. Ubuntu's `brightnessctl` package installs `/usr/lib/udev/rules.d/90-brightnessctl.rules`, which grants backlight write access to group `video`; user `mew` was not in group `video` when checked. The likely fix is `sudo usermod -aG video mew`, then log out and back in. If needed after that, trigger udev with `sudo udevadm trigger --subsystem-match=backlight`.
- Codex attempted `sudo usermod -aG video mew`, but sudo could not prompt for the password in the managed command environment. The user must run the brightness permission commands in a real terminal.
- Waybar uses FA4-compatible FontAwesome glyphs from Ubuntu's `fonts-font-awesome` package: CPU ``, memory ``, battery ``..``, brightness ``, volume ``, notifications ``, and power ``.
- Waybar is enlarged for the 5 inch uConsole display: `height=52`, global `font-size=17px`, key icons `20px`, and tighter window title length so the right-side resource modules still fit.
- Waybar module blocks/pill backgrounds were removed for a more integrated bar. Modules are transparent; active and urgent workspaces use bottom underline accents instead of filled blocks.
- Waybar no longer shows the launcher button, Wi-Fi/network module, or shortcut-help icon to reduce taskbar clutter. App launch remains `Super+Space` or `Super+d`, the shortcut sheet remains `Super+/`, and network settings remain `Super+Shift+n`.
- Waybar click actions: CPU opens `htop`; memory/RAM module opens `df -h` in a terminal for disk usage.
- Sway Notification Center (`sway-notification-center` 0.9.0-1build2) is installed and integrated as the preferred notification daemon. Sway starts `swaync` if available and falls back to `mako`; `Super+n` and the Waybar bell open it. Sway reload now restarts `swaync` so CSS changes apply with `Super+Shift+c`. Its CSS is intentionally flat/integrated: outer notification rows are transparent, and each notification uses one subtle surface with a thin teal accent instead of nested boxes.
- Wofi app launcher is enlarged for the 5 inch display: `width=88%`, `height=82%`, `font-size=18px`, and app icons `image_size=46`. Search is explicitly case-insensitive (`insensitive=true`) and uses predictable `matching=contains`. Wofi caching is enabled through `/home/mew/.cache/wofi-drun`, and `sort_order=default` keeps cached/frequent entries first. `allow_images=true` keeps app icons visible; this can make icon-theme loading visible when the launcher opens.
- Waybar battery is dynamic: discharging uses level icons ``..``, charging uses bolt ``, plugged/not charging uses plug ``, unknown uses ``, and charging/plugged states are green while warning/critical colors apply only when not charging.
- Power menu now uses compact Wofi instead of full-screen `wlogout`, so it visually matches the app launcher. `wlogout` remains installed but is not used by `~/.config/sway/power-menu.sh`.
- Theme switcher is available at `Super+Shift+t`. It offers Yaru/Adwaita plus installed Arc/Materia/Papirus/Numix choices. If the user chooses Materia/Papirus or another third-party theme, `snapd-desktop-integration` may try to install missing theme snaps at login. That warning is cosmetic for Sway/native GTK apps and can be ignored if Snap app theming does not matter. Switch to a Yaru/Adwaita choice for a quiet login.
- Lock screen uses `~/.config/sway/lock.sh`, which reads the current Sway wallpaper and applies a styled teal unlock indicator. All lock paths should call this helper: `Super+Control+l`, idle lock, before-sleep lock, and power-menu lock.
- Lock screen keypress strokes are bright green on a dim ring: `key-hl-color=87d99bff`, `ring-color=2b333bcc`, and `separator-color=101418ff`.
- Suspend is disabled in the Sway power menu because this uConsole currently fails to wake reliably after suspend/black-screen behavior. Swayidle now locks only; the previous `output * power off` idle action was removed.
- The power button is handled by systemd-logind, not Sway. Default logind behavior is `HandlePowerKey=poweroff`; recommended safe override until suspend is fixed is `HandlePowerKey=lock` plus `IdleAction=ignore` in `/etc/systemd/logind.conf.d/60-uconsole-power-key.conf`. Safe copy-paste command:
  `printf '%s\n' '[Login]' 'HandlePowerKey=lock' 'HandlePowerKeyLongPress=poweroff' 'IdleAction=ignore' | sudo tee /etc/systemd/logind.conf.d/60-uconsole-power-key.conf`
- Wallpaper picker is available at `Super+Shift+w` and persists wallpaper choices by updating the Sway config.
- Shortcut sheet `~/.config/sway/shortcuts.txt` has been cleaned up for spelling, wording, and consistent labels.
- Shortcut sheet opens fullscreen with `Super+/`; Sway rule for title `sway-shortcuts` is `fullscreen enable`.
- Workspace labels are predefined in `~/.config/sway/config` as `$ws1`..`$ws5`, and Waybar's persistent workspace list uses the same names.
- NetworkManager tray is started through `nm-applet --indicator` when available.
- Removable-drive tray handling is started through `udiskie --tray --notify` when available.
- Installed add-ons are now integrated: `pavucontrol`, `blueman`, `wdisplays`, `gammastep`, `cliphist`, `sway-notification-center`, `grimshot`, `udiskie`, `thunar`, `tumbler`, `mousepad`, `mpv`, `mpv-mpris`, `playerctl`, `evtest`, and `evemu-tools`.
- Thunar is the Sway file manager (`Super+Shift+f`), and Mousepad is the Sway text editor (`Super+Shift+v`).
- Screenshots now use `grimshot --notify`: `Print` saves the screen, `Shift+Print` saves a selected area, and `Super+Print` copies a selected area to the clipboard.
- Media keys use `playerctl`; `mpv-mpris` is installed system-wide under `/etc/mpv/scripts/mpris.so`, so mpv can expose MPRIS controls to playerctl-compatible panels and keys.
- `blueman-applet` starts automatically when available.
- `gammastep` starts automatically using approximate Sydney coordinates in `~/.config/gammastep/config.ini`; use `Super+Shift+g` to toggle it.
- Clipboard history is stored by `wl-paste --watch cliphist store`; use `Super+c` to pick an item and copy it back to the clipboard.
- The power menu uses the compact Wofi script at `~/.config/sway/power-menu.sh`; `wlogout` remains installed but is not used because the compact Wofi menu fits the uConsole display better.

## App And Polish Recommendations

These are optional and should be installed only if the user asks:

- `lxappearance`: lightweight GTK theme picker. Good for trying installed GTK themes from inside Sway.
- `qt5ct qt6ct`: Qt app theme tools, useful if Qt apps look mismatched.
- `pamixer`: audio CLI helper; current config uses `wpctl`, so this is optional.
- `variety`: wallpaper manager/rotator; heavier than the built-in `Super+Shift+w` picker and may need a custom Sway command.

Checked Ubuntu packages on this machine: `lxappearance`, `qt5ct`, `qt6ct`, `pamixer`, and `variety` are available. `nwg-look` and `azote` were not available from the current apt package search.

## Recovery

If Sway opens but the config needs work:

1. Press `Super+Enter` for a terminal.
2. Edit `~/.config/sway/config`.
3. Press `Super+Shift+c` to reload.

If Sway is unusable:

1. Press `Super+Shift+e` to exit, or switch TTY with `Ctrl+Alt+F3`.
2. Log back into GNOME from the login screen.
3. Rename the Sway config:

```bash
mv ~/.config/sway/config ~/.config/sway/config.disabled
```

Then Sway will fall back to defaults or you can restore/edit the config from GNOME.
