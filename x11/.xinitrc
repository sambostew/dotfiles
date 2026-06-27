#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

xrandr --newmode "3840x2160R120" 1097.25 3840 3888 3920 4000 2160 2163 2168 2287 +hsync -vsync 2>/dev/null
xrandr --addmode DisplayPort-0 "3840x2160R120" 2>/dev/null

xrandr --output HDMI-A-0     --mode 3840x2160 --rate 120 --pos 0x0    --rotate normal \
       --output DisplayPort-1 --primary --mode 3840x2160 --rate 120 --pos 3840x0 --rotate normal \
       --output DisplayPort-0 --mode 3840x2160R120 --pos 7680x0 --rotate normal

# xrandr returns before all three outputs finish mode-setting. Without this wait,
# i3's exec_always for feh/polybar/conky/picom fires against an incomplete layout
# and wallpapers/bars end up applied to the wrong (or only one) monitor.
for _ in $(seq 1 20); do
  [ "$(xrandr --listactivemonitors | grep -c '3840/')" -eq 3 ] && break
  sleep 0.25
done

exec i3
