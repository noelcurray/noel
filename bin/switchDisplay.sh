#! /bin/bash
var1=`xrandr | grep -A1 'HDMI-1' | grep '*'`

if [[ ! -z "$var1" ]];
then
	notify-send "Cintiq OFF, DELL ON"
	xrandr --output HDMI-1 --off
	xrandr --output DVI-D-1 --auto
else

	notify-send "Cintiq ON, DELL OFF"
	xrandr --output HDMI-1 --auto --size 1920x1200
	xrandr --output DVI-D-1 --off
fi

#case $1 in
#	on)
#		xrandr --output HDMI-1 --auto --below DVI-D-1;;
#	off)
#		xrandr --output HDMI-1 --off;;
#esac
