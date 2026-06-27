#!/usr/bin/env bash

# Monitor configuration moved to ~/dotfiles/x11/.xinitrc — running xrandr
# here on every i3 reload caused a race with feh's exec_always: feh would
# query RandR mid mode-set and apply the wallpaper to a subset of outputs.

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Give i3 time to finish reloading before polybar connects to its IPC socket
sleep 1

# Launch polybar on each connected monitor
for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload example >>/tmp/polybar-$m.log 2>&1 &
done

echo "Bars launched..."
