#!/bin/sh
# Shared cache so all three bars show the same count — independent execs
# raced the hourly DB sync and disagreed (80 vs 132, 2026-07-17).
cache=${XDG_RUNTIME_DIR:-/tmp}/waybar-updates
exec 9>"$cache.lock"
flock 9
age=$(( $(date +%s) - $(stat -c %Y "$cache" 2>/dev/null || echo 0) ))
if [ ! -s "$cache" ] || [ "$age" -gt 3500 ]; then
    paru -Qu 2>/dev/null | wc -l > "$cache"
fi
cat "$cache"
