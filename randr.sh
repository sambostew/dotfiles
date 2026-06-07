#!/bin/sh
xrandr --output HDMI-A-0 --mode 2560x1440 --pos 0x0 --rotate normal \
       --output DisplayPort-3 --primary --mode 2560x1440 --pos 2560x0 --rotate normal \
       --output DVI-D-0 --off \
       --output DisplayPort-2 --mode 2560x1440 --pos 5120x0 --rotate normal \
       --output DP-0 --off --output DP-1 --off --output DP-2 --off
