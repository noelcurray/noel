#!/bin/sh

GETSTYLUSID=`xsetwacom list devices`

ID_STYLUS=$(echo $GETSTYLUSID | cut -d " " -f 7)
ID_ERASER=$(echo $GETSTYLUSID | cut -d " " -f 16)
#SCREEN_TARGET=$(echo $(xrandr| grep HDMI | cut -d " " -f 3))
xsetwacom set $ID_STYLUS MapToOutput "HDMI-1"
xsetwacom set $ID_ERASER  MapToOutput "HDMI-1"
dunstify "Wacom pen is now mapped in HDMI-1"

