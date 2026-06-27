#!/bin/sh
xrandr --newmode "3840x2160R120" 1097.25 3840 3888 3920 4000 2160 2163 2168 2287 +hsync -vsync 2>/dev/null
xrandr --addmode DisplayPort-0 "3840x2160R120" 2>/dev/null

xrandr --output HDMI-A-0     --mode 3840x2160 --rate 120 --pos 0x0    --rotate normal \
       --output DisplayPort-1 --primary --mode 3840x2160 --rate 120 --pos 3840x0 --rotate normal \
       --output DisplayPort-0 --mode 3840x2160R120 --pos 7680x0 --rotate normal
