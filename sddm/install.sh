#!/bin/sh
# SDDM is system-level and ~ is 0700 (the sddm user can't follow symlinks
# into it), so unlike the rest of the repo these are COPIES — run this with
# sudo after changing anything here.
#
# Only the customized files are tracked; the rest of the sugar-candy theme
# (~36M of upstream assets) is a manual install at
# /usr/share/sddm/themes/sugar-candy (not pacman-owned).
# Main.qml: patched 2026-07-18 so the login form + PartialBlur glass render
# only on DisplayPort-1 (centre); falls back to all screens if that output
# name ever disappears (no lockout).
set -e
d=$(dirname "$(realpath "$0")")
t=/usr/share/sddm/themes/sugar-candy
cp "$d/sugar-candy/Main.qml" "$t/Main.qml"
cp "$d/sugar-candy/theme.conf" "$t/theme.conf"
cp "$d/sugar-candy/god.png" "$t/Backgrounds/god.png"
mkdir -p /etc/sddm.conf.d
cp "$d/sddm.conf.d-theme.conf" /etc/sddm.conf.d/theme.conf
echo "installed — takes effect at next SDDM start"
