#!/bin/sh

function send_notification() {
	dunstify -a "changebrightness" -u normal -r 0002 -t 1000 "Brightness" "$1" -h int:value:"$1" 
}

case $1 in
	+5)
		brightnessctl set +5%
		send_notification $(brightnessctl -m | cut -d "," -f 4)
		;;
	-5)
		brightnessctl set 5%-
		send_notification $(brightnessctl -m | cut -d "," -f 4)
		;;
esac

