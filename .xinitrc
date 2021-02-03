#!/bin/sh

# Load screen calibration profile
/usr/bin/xcalib -d :0 $HOME/.config/asusVS247.icm

# Autostart
exec dwm