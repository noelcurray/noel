#!/bin/sh

# run $xrandr to get the WIDTHXSCREEN_HEIGHT+0+0
# run xsetwacom list devices to get the id of stylus
xrandr --output HDMI-A-0 --auto --below DVI-D-0

GETSTYLUSID=`xsetwacom list devices`

ID_STYLUS=$(echo $GETSTYLUSID | cut -d " " -f 7)
ID_ERASER=$(echo $GETSTYLUSID | cut -d " " -f 16)
SCREEN_TARGET=$(echo `xrandr| grep HDMI | cut -d " " -f 3`)
echo "stylus id is: $ID_STYLUS"
echo "eraser id is: $ID_ERASER"
echo "screen target is: $SCREEN_TARGET"
xsetwacom set $ID_STYLUS MapToOutput $SCREEN_TARGET
xsetwacom set $ID_ERASER  MapToOutput $SCREEN_TARGET

