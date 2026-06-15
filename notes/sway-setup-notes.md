# Sway Setup Notes

Created: 2026-06-13
Last updated: 2026-06-15

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
- Helper scripts: `~/.config/sway/terminal.sh`, `~/.config/sway/power-menu.sh`, `~/.config/sway/power-key.sh`, `~/.config/sway/clipboard-menu.sh`, `~/.config/sway/gammastep-toggle.sh`, `~/.config/sway/window-menu.sh`, `~/.config/sway/wallpaper-menu.sh`, `~/.config/sway/brightness.sh`, `~/.config/sway/brightness-menu.sh`, `~/.config/sway/volume.sh`, `~/.config/sway/media-status.sh`, `~/.config/sway/media-status-loop.sh`, `~/.config/sway/theme-menu.sh`, `~/.config/sway/theme-apply.sh`, `~/.config/sway/lock.sh`, `~/.config/sway/notifications.sh`

## First Login

The bar should appear at the top with:

- Workspaces and focused window title
- CPU, memory, battery, brightness when available, volume, media status, clock, and tray
- No taskbar launcher icon, network module, shortcut-help icon, notification icon, or power icon; those remain available by keyboard shortcut

Key starting points:

- `Super+Enter`: terminal
- `Super+Shift+Enter`: fullscreen terminal
- `Super+grave`: scratchpad terminal
- `Super+Space`: app launcher
- `Super+d`: app launcher too
- `Super+Shift+Space`: run prompt
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
- `Super+Shift+r`: Shairport TUI
- `Super+Control+f`: toggle floating mode
- `Super+Shift+o`: Bluetooth manager
- `Super+Shift+d`: display settings
- `Super+Shift+g`: toggle night color
- `Super+Shift+t`: theme switcher
- `Super+Shift+w`: wallpaper picker
- `Super+Shift+c`: reload config
- `Super+Shift+e`: exit Sway
- Physical power button: tap for power menu, hold 2 seconds to shut down

The bar uses FontAwesome icons for CPU, memory, battery, brightness, and volume. The app launcher shortcut is `Super+Space` or `Super+d`; there is intentionally no launcher, notification-center, or power-menu button on the bar. Network settings remain available with `Super+Shift+n`, notifications remain `Super+n`, the power menu remains `Super+Shift+p`, and volume opens `pavucontrol` when clicked.

## Workspaces

- Workspaces 1..6 are predefined with compact FontAwesome labels: `1 ` terminal, `2 ` browser, `3 ` files, `4 ` mail, `5 ` tools, and `6 ` music.
- `Super+1..6` switches to those named workspaces; `Super+Shift+1..6` moves the focused window there.
- Workspaces 7..10 remain plain numeric overflow workspaces.
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
- Foot server mode is disabled. Sway no longer starts `foot --server`; `~/.config/sway/terminal.sh` launches standalone `foot --term=foot`.
- Foot uses `term=foot`, and `~/.config/sway/terminal.sh` exports `CODEX_TUI_DISABLE_KEYBOARD_ENHANCEMENT=1` before launching Foot to avoid duplicate key behavior in Codex.
- Keyboard repeat is slowed for the uConsole keyboard with `repeat_delay 850` and `repeat_rate 10`. Backspace double-delete was isolated to Codex keyboard enhancement rather than global terminal repeat, so Sway repeat was restored from the temporary disabled setting and Codex enhancement is disabled in the terminal wrapper.
- If duplicate key events happen outside Codex, diagnose hardware key bounce with `wev` under Sway. Optional packages available for deeper keyboard diagnostics/filtering include `evtest`, `evemu-tools`, `input-remapper`, and `interception-tools`.
- Brightness uses `~/.config/sway/brightness.sh` with device `backlight@0` and one hardware step per press. The panel exposes only 9 levels, so percentage steps like `5%+` can be too small to work visibly. Shortcuts are `Super+Control+Up` and `Super+Control+Down`; hardware brightness keys and Waybar brightness scrolling call the same helper. Clicking the Waybar brightness module opens `~/.config/sway/brightness-menu.sh`, a compact Wofi picker for 10/25/40/55/70/85/100%.
- Volume is controlled through `~/.config/sway/volume.sh` for hardware volume keys and Waybar volume scroll/right-click. Volume up remains capped at 100% with `wpctl set-volume -l 1.0 ... 5%+`, and the helper shows notification feedback for volume and mic mute changes.
- If brightness still cannot be changed from inside Sway, check permissions. Ubuntu's `brightnessctl` package installs `/usr/lib/udev/rules.d/90-brightnessctl.rules`, which grants backlight write access to group `video`; user `mew` was not in group `video` when checked. The likely fix is `sudo usermod -aG video mew`, then log out and back in. If needed after that, trigger udev with `sudo udevadm trigger --subsystem-match=backlight`.
- Codex attempted `sudo usermod -aG video mew`, but sudo could not prompt for the password in the managed command environment. The user must run the brightness permission commands in a real terminal.
- Waybar uses the selected Option B status glyph set from FontAwesome/Noto: CPU ``, memory ``, battery ``..`` plus charging `` and plugged ``, brightness ``, volume ``, and muted volume ``. The originally proposed `` muted glyph is not covered by the installed FontAwesome package, so the supported `` glyph is used. The notification-center and power-menu icons were removed from the bar; use `Super+n` and `Super+Shift+p`.
- Waybar is enlarged for the 5 inch uConsole display: `height=52`, global `font-size=17px`, key icons `20px`, compact workspace button spacing, and tighter window/media lengths so the right-side resource modules still fit.
- Waybar module blocks/pill backgrounds were removed for a more integrated bar. Modules are transparent; active and urgent workspaces use bottom underline accents instead of filled blocks. Right-side status spacing is tightened with Waybar `spacing=2`, module padding `0 5px`, and tray spacing `6`.
- Waybar no longer shows the launcher button, Wi-Fi/network module, shortcut-help icon, notification icon, or power-menu icon to reduce taskbar clutter. App launch remains `Super+Space` or `Super+d`, the shortcut sheet remains `Super+/`, network settings remain `Super+Shift+n`, notifications remain `Super+n`, and the power menu remains `Super+Shift+p`.
- Waybar hover text is concise and action-aware across CPU, memory, battery, brightness, volume, media, and clock. Battery hover avoids unreliable remaining-time placeholders and uses state wording such as `On battery`, `Charging`, or `Plugged in`.
- Waybar click actions: CPU opens `htop`; memory/RAM module opens `df -h` in a terminal for disk usage; brightness opens the compact Wofi brightness picker; volume opens `pavucontrol` and right-click toggles mute.
- Waybar includes a fast `custom/media` playerctl status module after audio. It runs `~/.config/sway/media-status-loop.sh`, which emits fresh JSON from `media-status.sh` every second so now-playing changes do not depend on Waybar's interval timer and exits when Waybar closes the pipe during reload. It uses `` for playing, `` for paused, and `` for stopped/no active player. It shows bounded artist-first track text while playing and for up to 10 minutes after active playback; the visible cap is 40 characters by default, while the tooltip keeps the full artist/title. The custom module uses `escape=true` because Waybar parses custom text as markup and unescaped `&` in artist names otherwise causes stale display. The helper avoids per-poll Sway IPC queries so now-playing updates are not delayed by workspace state checks. After stale playback, paused/stopped states collapse to icon-only. Click toggles play/pause and right-click opens Shairport TUI.
- Wofi run prompt is available at `Super+Shift+Space`; app launcher remains `Super+Space` and `Super+d`.
- Scratchpad terminal is available at `Super+grave`. It launches a floating Foot terminal titled `sway-scratchpad-terminal` and toggles it through Sway scratchpad.
- Floating mode toggle moved from `Super+Shift+Space` to `Super+Control+f` to leave `Super+Shift+Space` for the run prompt.
- Shairport TUI is available at `Super+Shift+r`. It launches `/home/mew/bin/shairport-tui` in a fullscreen Foot terminal with title `shairport-tui` on the current workspace.
- Sway Notification Center (`sway-notification-center` 0.9.0-1build2) is installed and integrated as the preferred notification daemon. Sway starts `swaync` if available and falls back to `mako`; `Super+n` opens it, with no Waybar notification icon. The control center opens flush to the top edge (`control-center-margin-top=0`) with only bottom corners rounded. Sway reload now restarts `swaync` so CSS changes apply with `Super+Shift+c`. Its CSS is intentionally flat/integrated: outer notification rows are transparent, and each notification uses one subtle surface with a thin teal accent instead of nested boxes.
- Wofi app launcher is enlarged for the 5 inch display: `width=88%`, `height=82%`, `font-size=18px`, and app icons `image_size=46`. Search is explicitly case-insensitive (`insensitive=true`) and uses predictable `matching=contains`. Wofi caching is enabled through `/home/mew/.cache/wofi-drun`, and `sort_order=default` keeps cached/frequent entries first. `allow_images=true` keeps app icons visible; this can make icon-theme loading visible when the launcher opens.
- Waybar battery is dynamic: discharging uses level icons ``..``, charging uses bolt ``, plugged/not charging uses plug ``, unknown uses ``, and charging/plugged states are green while warning/critical colors apply only when not charging. Battery hover intentionally omits `{time}` because the uConsole battery path does not expose reliable time estimates.
- Power menu now uses compact Wofi instead of full-screen `wlogout`, so it visually matches the app launcher. `wlogout` remains installed but is not used by `~/.config/sway/power-menu.sh`.
- Theme switcher is available at `Super+Shift+t`. It offers Yaru/Adwaita plus installed Arc/Materia/Papirus/Numix choices. If the user chooses Materia/Papirus or another third-party theme, `snapd-desktop-integration` may try to install missing theme snaps at login. That warning is cosmetic for Sway/native GTK apps and can be ignored if Snap app theming does not matter. Switch to a Yaru/Adwaita choice for a quiet login.
- Lock screen uses `~/.config/sway/lock.sh`, which reads the current Sway wallpaper and applies a styled teal unlock indicator. All lock paths should call this helper: `Super+Control+l`, idle lock, before-sleep lock, and power-menu lock.
- Lock screen keypress strokes are bright green on a dim ring: `key-hl-color=87d99bff`, `ring-color=2b333bcc`, and `separator-color=101418ff`.
- Suspend is disabled in the Sway power menu because this uConsole currently fails to wake reliably after suspend/black-screen behavior. Swayidle now locks only; the previous `output * power off` idle action was removed.
- The physical power button is routed to Sway through `~/.config/sway/power-key.sh`. Default logind behavior is `HandlePowerKey=poweroff`; recommended override is `HandlePowerKey=ignore` plus `IdleAction=ignore` in `/etc/systemd/logind.conf.d/60-uconsole-power-key.conf`, while Sway binds raw keycode `124` press/release events to `power-key.sh`. Tapping the button opens the compact Wofi power menu; holding it for 2 seconds runs `systemctl poweroff` and suppresses the menu. Safe copy-paste command:
  `printf '%s\n' '[Login]' 'HandlePowerKey=ignore' 'HandlePowerKeyLongPress=poweroff' 'IdleAction=ignore' | sudo tee /etc/systemd/logind.conf.d/60-uconsole-power-key.conf`
- Wallpaper picker is available at `Super+Shift+w` and persists wallpaper choices by updating the Sway config.
- Shortcut sheet `~/.config/sway/shortcuts.txt` has been cleaned up for spelling, wording, and consistent labels.
- Shortcut sheet opens fullscreen with `Super+/`; Sway rule for title `sway-shortcuts` is `fullscreen enable`.
- Workspace labels are predefined in `~/.config/sway/config` as `$ws1`..`$ws6`, and Waybar's persistent workspace list uses the same names.
- NetworkManager tray is started through `nm-applet --indicator` when available.
- Removable-drive tray handling is started through `udiskie --tray --notify` when available.
- Installed add-ons are now integrated: `pavucontrol`, `blueman`, `wdisplays`, `gammastep`, `cliphist`, `sway-notification-center`, `grimshot`, `udiskie`, `thunar`, `tumbler`, `mousepad`, `mpv`, `mpv-mpris`, `playerctl`, `evtest`, and `evemu-tools`.
- Thunar is the Sway file manager (`Super+Shift+f`), and Mousepad is the Sway text editor (`Super+Shift+v`).
- Screenshots now use `grimshot --notify`: `Print` saves the screen, `Shift+Print` saves a selected area, and `Super+Print` copies a selected area to the clipboard.
- Media keys use `playerctl`; `mpv-mpris` is installed system-wide under `/etc/mpv/scripts/mpris.so`, so mpv can expose MPRIS controls to playerctl-compatible panels and keys.
- `blueman-applet` starts automatically when available.
- `gammastep` remains installed and can be toggled manually with `Super+Shift+g`, but it no longer autostarts because the current display path reports no gamma adjustment support and otherwise spams the journal.
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
