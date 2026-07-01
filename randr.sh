#!/bin/sh
# Applies the 3-monitor 4K layout. Handles the AMDGPU HDMI cold-boot flap:
# HDMI-A-0 can silently fail its first modeset and stick at its EDID fallback
# (1440p +0+0). Re-issuing the same xrandr command is a no-op — xrandr sees
# the mode as already requested. Only a full --off + re-mode forces fresh
# HDMI link training. Recovery runs in the background so .xinitrc can
# continue to exec i3 without blocking.

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

apply_layout
fb_ok && exit 0

(
  for _ in $(seq 1 30); do
    fb_ok && exit 0
    xrandr --output HDMI-A-0 --off 2>/dev/null
    sleep 1
    apply_layout
    sleep 1
  done
) &

exit 0
