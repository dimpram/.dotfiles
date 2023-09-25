#!/bin/sh

# DEFAULT xinitrc stuff
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

# END DEFUALT xinitrc stuff

# Load nvidia optimus
/usr/bin/prime-offload

#/usr/bin/prime-switch

# Load wallpaper
~/.fehbg &

# Load screen calibration profile
/usr/bin/xcalib -d :0 $HOME/.config/asusVS247.icm

# Start notification daemon
exec dunst &

# Start picom
exec picom &

# Start battery notification script
exec ~/.local/bin/battery &

# Start window manager
exec dwm
