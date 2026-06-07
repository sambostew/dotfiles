#!/usr/bin/env bash

# Configure monitors before launching bars
xrandr --output HDMI-A-0 --mode 2560x1440 --pos 0x0 --rotate normal \
       --output DisplayPort-3 --primary --mode 2560x1440 --pos 2560x0 --rotate normal \
       --output DVI-D-0 --off \
       --output DisplayPort-2 --mode 2560x1440 --pos 5120x0 --rotate normal \
       --output DP-0 --off --output DP-1 --off --output DP-2 --off

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
