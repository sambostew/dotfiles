#!/bin/sh
# Apply the 3-monitor 4K layout. Idempotent — safe to call repeatedly.
# HDMI-A-0 sometimes silently fails its first modeset on cold boot and
# sticks at its EDID fallback (1440p +0+0); re-issuing xrandr with the
# same mode is a no-op because xrandr thinks the mode is already set,
# so we need an explicit --off before re-applying to force fresh link
# training. Any post-startup flaps are caught by hotplug-watcher.sh.

apply_layout() {
  xrandr --output DisplayPort-0 --mode 3840x2160 --rate 120 --pos 0x0    --rotate normal \
         --output DisplayPort-1 --primary --mode 3840x2160 --rate 120 --pos 3840x0 --rotate normal \
         --output HDMI-A-0      --mode 3840x2160 --rate 60  --pos 7680x0 --rotate normal 2>/dev/null
}

fb_ok() {
  [ "$(xdpyinfo 2>/dev/null | awk '/dimensions:/ {print $2}')" = "11520x2160" ]
}

for _ in $(seq 1 40); do
  c=$(xrandr --query 2>/dev/null | grep -Ec "^(HDMI-A-0|DisplayPort-0|DisplayPort-1) connected")
  [ "$c" -eq 3 ] && break
  sleep 0.25
done

for _ in 1 2 3; do
  apply_layout
  sleep 1
  fb_ok && exit 0
  xrandr --output HDMI-A-0 --off 2>/dev/null
  sleep 1
done

exit 1
