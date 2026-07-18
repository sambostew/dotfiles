#!/bin/sh
# Generate pywal palette (no wallpaper-setting, no terminal sequences —
# same -n -s flags as the old i3 exec_always), then draw via awww.
wal -i "$HOME/Pictures/godmode.jpg" -n -s
awww img "$HOME/Pictures/godmode.jpg" --transition-type fade

# Reload waybar CSS so it picks up the fresh pywal palette (no-op if
# waybar isn't running yet — Phase B / future wallpaper rotation).
pgrep -x waybar >/dev/null && pkill -SIGUSR2 waybar

# Dunst reads its colours from a dunstrc.d drop-in rendered by wal above.
pgrep -x dunst >/dev/null && dunstctl reload
