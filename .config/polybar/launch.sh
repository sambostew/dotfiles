#!/usr/bin/env bash

# Configure monitors before launching bars
xrandr --newmode "3840x2160R120" 1097.25 3840 3888 3920 4000 2160 2163 2168 2287 +hsync -vsync 2>/dev/null
xrandr --addmode DisplayPort-0 "3840x2160R120" 2>/dev/null

xrandr --output HDMI-A-0     --mode 3840x2160 --rate 120 --pos 0x0    --rotate normal \
       --output DisplayPort-1 --primary --mode 3840x2160 --rate 120 --pos 3840x0 --rotate normal \
       --output DisplayPort-0 --mode 3840x2160R120 --pos 7680x0 --rotate normal

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
