#! /bin/bash
message="null"
var1=$(xrandr | grep -A1  HDMI-1| grep "*")

function pen_map() {
	GETSTYLUSID=`xsetwacom list devices`	
	ID_STYLUS=$(echo $GETSTYLUSID | cut -d " " -f 7)
	ID_ERASER=$(echo $GETSTYLUSID | cut -d " " -f 16)
	xsetwacom set $ID_STYLUS MapToOutput "$1"
	xsetwacom set $ID_ERASER  MapToOutput "$1"
}

case $1 in
	--swap-display)
		if [[ -z "$var1" ]]; then
			message="HDMI on, DVI off"
			xrandr --output DVI-D-1	--off
			xrandr --output HDMI-1	--auto
			pen_map HDMI-1
		else
			message="HDMI off, DVI on"
			xrandr --output DVI-D-1	--auto
			xrandr --output HDMI-1	--off
			pen_map DVI-D-1
		fi
		;;

	--switch-power)
		var1=$(xrandr | grep -A1  HDMI-1| grep "*")
		if [[ -z "$var1" ]]; then
			xrandr --output HDMI-1	--auto --below DVI-D-1
			pen_map HDMI-1
			message="HDMI on"
		else
			var1=$(xrandr | grep -A1  DVI-D-1| grep "*")
			if [[ ! -z "$var1" ]]; then
				message="HDMI off"
				xrandr --output HDMI-1 --off
				pen_map DVI-D-1
			else
				message="DVI on"
				xrandr --output DVI-D-1 --auto
				xrandr --output HDMI-1	--off
				pen_map DVI-D-1
			fi
		fi
		;;

	*)
		message="please add --swap-display or --switch-power"
		;;
esac

dunstify "Wacom display switcher" "$message" -r 0010
