#!/bin/bash


notify_plug=false
notify_bat_full=false
brightness_100=false
battery_icon=none
function brightnesstoggle() {
	if [ brightness_100 = false ] ; then
		brightnessctl set 100%
		brightness_100=true
	else
		brightness_100=false
	fi
}

function batt_icon_charging() {
	case $1 in
		100) battery_icon="󰂅" ;;
		9[0-9]) battery_icon="󰂋" ;;
		8[0-9]) battery_icon="󰂊" ;;
		7[0-9]) battery_icon="󰢞" ;;
		6[0-9]) battery_icon="󰂉" ;;
		5[0-9]) battery_icon="󰢝" ;;
		4[0-9]) battery_icon="󰂈" ;;
		3[0-9]) battery_icon="󰂇" ;;
		2[0-9]) battery_icon="󰂆" ;;
		1[0-9]) battery_icon="󰢜" ;;
		0[0-9]) battery_icon="󰢟" ;;
	esac

}


function batt_icon_discharging() {
	case $1 in
		100) battery_icon="󰁹" ;;
		9[0-9]) battery_icon="󰂂" ;;
		8[0-9]) battery_icon="󰂁" ;;
		7[0-9]) battery_icon="󰂀" ;;
		6[0-9]) battery_icon="󰁿" ;;
		5[0-9]) battery_icon="󰁾" ;;
		4[0-9]) battery_icon="󰁽" ;;
		3[0-9]) battery_icon="󰁼" ;;
		2[0-9]) battery_icon="󰁻" ;;
		1[0-9]) battery_icon="󰁺" ;;
		0[0-9]) battery_icon="󰂎" ;;
	esac

}

function battery_checker() {
	date_display=$(date +'%Y-%m-%d %T')
	batt_stat=$(cat /sys/class/power_supply/BAT0/status)
	batt_cap=$(cat /sys/class/power_supply/BAT0/capacity)
	sys_temp=$(acpi -t | cut -d " " -f 4)

      if [ $batt_stat = "Charging" ] ; then
	      batt_icon_charging $batt_cap
      	if [ $batt_cap -ge 100 ] ; then
      		if [ $notify_bat_full = false ] ; then
      			dunstify -i "󰂃" -u critical -h string:bgcolor:"#007500" -h string:frcolor:"#007500" "Battery Full." && paplay --volume=98304 ~/.local/share/sounds/battery_full.mp3
      			notify_bat_full=true
      		fi 
      	else
      		notify_bat_full=false
      	fi
      		
	if [ $batt_cap -ge 21 ] ; then notify_plug=false ; fi

      else ## discharging
	      batt_icon_discharging $batt_cap
      	notify_bat_full=false
      	if [ $batt_cap -le 20 ] ; then
      		if [ $notify_plug = false ] ; then
      			dunstify "Please plug the charger." -u critical && paplay --volume=98304 ~/.local/share/sounds/please_charge.mp3
      			notify_plug=true
      		fi
      	fi
      	
      fi

	echo 󰔏 $sys_temp°C \| $battery_icon\($batt_cap\%\) \| $date_display 
}

while true 
do
	battery_checker
	sleep 1
done

