#!/bin/sh
# Wait for X/kernel to report all 3 outputs as connected. On cold boot, AMD's
# HDMI 2.1 FRL link training and DP DSC handshake can take several seconds —
# issuing the modeset before the kernel sees the outputs leaves the layout at
# 2560x1440 mirrored (Xorg's EDID-less fallback).
for _ in $(seq 1 40); do
  c=$(xrandr --query | grep -E "^(HDMI-A-0|DisplayPort-0|DisplayPort-1) connected" | wc -l)
  [ "$c" -eq 3 ] && break
  sleep 0.25
done

xrandr --newmode "3840x2160R120" 1097.25 3840 3888 3920 4000 2160 2163 2168 2287 +hsync -vsync 2>/dev/null
xrandr --addmode DisplayPort-0 "3840x2160R120" 2>/dev/null

# Retry the modeset itself — the first attempt occasionally fails silently on
# cold boot (output stays at EDID-default) and we land mirrored at 2K.
for _ in $(seq 1 5); do
  xrandr --output DisplayPort-0 --mode 3840x2160R120 --pos 0x0    --rotate normal \
         --output DisplayPort-1 --primary --mode 3840x2160 --rate 120 --pos 3840x0 --rotate normal \
         --output HDMI-A-0      --mode 3840x2160 --rate 60  --pos 7680x0 --rotate normal
  [ "$(xrandr --listactivemonitors | grep -c '3840/')" -eq 3 ] && break
  sleep 1
done
