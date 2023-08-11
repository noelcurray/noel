#!/bin/sh

GETSTYLUSID=`xsetwacom list devices`

ID_STYLUS=$(echo $GETSTYLUSID | cut -d " " -f 7)
ID_ERASER=$(echo $GETSTYLUSID | cut -d " " -f 16)
SCREEN_TARGET=$(echo `xrandr| grep HDMI | cut -d " " -f 3`)
echo "stylus id is: $ID_STYLUS"
echo "eraser id is: $ID_ERASER"
echo "screen target is: $SCREEN_TARGET"
xsetwacom set $ID_STYLUS MapToOutput $SCREEN_TARGET
xsetwacom set $ID_ERASER  MapToOutput $SCREEN_TARGET

