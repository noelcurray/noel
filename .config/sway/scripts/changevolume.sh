#!/bin/sh

function send_notification() {
	remove_decimal=$(get_current_volume -no_decimal)
	remove_percentage=$(get_current_volume -no_percent_char)
	if [ ! $1 = mute ] ; then
		dunstify -a "changevolume" -u normal -r 9993 -h int:value:"$remove_decimal" "Volume-$1" "${remove_percentage}" -t 1000
	else
		dunstify -a "changevolume" -u low -r 9993 $(pactl get-sink-mute @DEFAULT_SINK@)
	fi
		
}

function get_current_volume() {
	for word in $(pactl get-sink-volume @DEFAULT_SINK@)
	do 
		pactl_volume+=($word) 
	done
	no_percent_char=$(echo ${pactl_volume[4]} | sed 's/%//')

	if [ $no_percent_char -ge $max_volume ] ; then
		no_percent_char=$(echo $max_volume)
		pactl set-sink-volume @DEFAULT_SINK@ $max_volume\%
	fi

	volume_150=$(echo $no_percent_char/$max_volume | bc -l)
	convert_to_int=$(echo $volume_150 \* 100 | bc -l)
	no_decimal=$(echo ${convert_to_int%.*})

	case $1 in
		-no_decimal)
			echo $no_decimal
			;;
		-no_percent_char)
			echo $no_percent_char
			;;		
	esac
}

function volume_adjust() {
	case $1 in
		up)	
			pactl set-sink-mute @DEFAULT_SINK@ 0
			pactl set-sink-volume @DEFAULT_SINK@ +5%
			send_notification $1
			;;
		down)
			pactl set-sink-mute @DEFAULT_SINK@ 0
			pactl set-sink-volume @DEFAULT_SINK@ -5%
			send_notification $1
			;;
		mute)
			pactl set-sink-mute @DEFAULT_SINK@ toggle
			send_notification $1
			;;
	esac
}

max_volume=150
volume_adjust $1
