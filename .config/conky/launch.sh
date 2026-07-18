#!/bin/sh
# conky's Wayland backend passes a NULL output to zwlr_layer_shell (checked
# v1.22.3 display-wayland.cc:578) so the compositor maps it on whatever
# monitor is focused at start — pin to HDMI-A-1 by focusing it briefly.
export HYPRLAND_INSTANCE_SIGNATURE=${HYPRLAND_INSTANCE_SIGNATURE:-$(command ls -t /run/user/1000/hypr/ | head -1)}

prev=$(hyprctl monitors -j | python3 -c "import json,sys; print([m['name'] for m in json.load(sys.stdin) if m['focused']][0])")
hyprctl dispatch focusmonitor HDMI-A-1 >/dev/null
conky
sleep 1
hyprctl dispatch focusmonitor "$prev" >/dev/null
