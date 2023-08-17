#! /bin/bash
var1=`xrandr | grep -A1 'HDMI-1' | grep '*'`

if [[ ! -z "$var1" ]];
then
	dunstify "Cintiq OFF, DELL ON"
	xrandr --output HDMI-1 --off
	xrandr --output DVI-D-1 --auto
else

	dunstify "Cintiq ON, DELL OFF"
	xrandr --output HDMI-1 --auto --size 1920x1080
	xrandr --output DVI-D-1 --off
fi
