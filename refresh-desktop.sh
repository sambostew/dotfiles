#!/bin/sh
# Sync the desktop to the current monitor layout: apply xrandr, wait for
# the framebuffer to settle, then relaunch anything that positions itself
# against the layout (conky, feh wallpaper, polybar).
#
# Called from:
#   - i3 exec_always      → runs on i3 startup, reload, and restart
#   - hotplug-watcher.sh  → runs on RandR change events
#   - manual keybind      → covered via Alt+Shift+R (i3 restart)
#
# Serialised via flock so overlapping invocations (e.g. i3 restart while
# the watcher is already firing) don't stomp on each other.

exec 9>/tmp/refresh-desktop.lock
flock -n 9 || exit 0

sh "$HOME/dotfiles/randr.sh"

for _ in $(seq 1 40); do
  [ "$(xdpyinfo 2>/dev/null | awk '/dimensions:/ {print $2}')" = "11520x2160" ] && break
  sleep 0.25
done

# Kill and *wait* for exit before restarting. killall is asynchronous —
# racing new instances against dying ones was leaving orphan windows.
killall -q conky
while pgrep -u "$UID" -x conky >/dev/null; do sleep 0.1; done

feh --bg-scale "$HOME/Pictures/godmode.jpg"
conky -c "$HOME/.config/conky/conky.conf" >/dev/null 2>&1 &
sh "$HOME/.config/polybar/launch.sh" >/dev/null 2>&1 &
