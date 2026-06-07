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

xrandr --output HDMI-A-0 --mode 2560x1440 --pos 0x0 --rotate normal \
       --output DisplayPort-3 --primary --mode 2560x1440 --pos 2560x0 --rotate normal \
       --output DVI-D-0 --off \
       --output DisplayPort-2 --mode 2560x1440 --pos 5120x0 --rotate normal \
       --output DP-0 --off --output DP-1 --off --output DP-2 --off

exec i3
