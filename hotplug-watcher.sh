#!/bin/sh
# Poll xdpyinfo for RandR framebuffer size changes and re-sync the desktop
# whenever the layout shifts. Exists because AMDGPU HDMI on Navi 4x can
# take up to ~30s of EDID re-reads before it locks in the 4K mode on cold
# boot, so anything launched at i3 startup ends up positioned against a
# broken/interim layout. A 2s settle delay avoids firing mid-transaction.

# Nuke any stale watcher (e.g. from an i3 crash + recovery).
for pid in $(pgrep -u "$UID" -f "dotfiles/hotplug-watcher.sh"); do
  [ "$pid" != "$$" ] && kill "$pid" 2>/dev/null
done

prev=$(xdpyinfo 2>/dev/null | awk '/dimensions:/ {print $2}')

while :; do
  sleep 3
  cur=$(xdpyinfo 2>/dev/null | awk '/dimensions:/ {print $2}')
  [ -z "$cur" ] && continue
  if [ "$cur" != "$prev" ]; then
    sleep 2
    cur=$(xdpyinfo 2>/dev/null | awk '/dimensions:/ {print $2}')
    if [ "$cur" != "$prev" ]; then
      sh "$HOME/dotfiles/refresh-desktop.sh"
      prev=$(xdpyinfo 2>/dev/null | awk '/dimensions:/ {print $2}')
    fi
  fi
done
