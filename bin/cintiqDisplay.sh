#! /bin/bash
var1=`xrandr | grep -A1 'HDMI-1' | grep '*'`

if [[ ! -z "$var1" ]];
then
	echo "cintiq turn off."
	notify-send "Cintiq 16 is turn off"
	xrandr --output HDMI-1 --off
else
	echo "cintiq turn on."
	notify-send "Cintiq 16 is turned on"
	xrandr --output DVI-D-1 --auto
	xrandr --output HDMI-1 --auto --below DVI-D-1
	SCREEN_TARGET=$(echo `xrandr| grep HDMI-1 | cut -d " " -f 3`)
	GETSTYLUSID=`xsetwacom list devices`
	ID_STYLUS=$(echo $GETSTYLUSID | cut -d " " -f 7)
	ID_ERASER=$(echo $GETSTYLUSID | cut -d " " -f 16)
	xsetwacom set $ID_STYLUS MapToOutput $SCREEN_TARGET
	xsetwacom set $ID_ERASER  MapToOutput $SCREEN_TARGET
fi

#case $1 in
#	on)
#		xrandr --output HDMI-1 --auto --below DVI-D-1;;
#	off)
#		xrandr --output HDMI-1 --off;;
#esac
