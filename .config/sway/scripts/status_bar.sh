#!/bin/bash

DATE_FORMATTED=$(date +'%Y-%m-%d %T')

BATTERY_STATUS=$(cat /sys/class/power_supply/BAT0/status)

BATTERY_PERCENTAGE=$(cat /sys/class/power_supply/BAT0/capacity)

SYSTEM_TEMP=$(acpi -t | cut -d " " -f 4)

STATUS_DATA_DIR=~/.config/sway/status_data

function brightnesstoggle() {
	brightness_status=$(grep fullBright $STATUS_DATA_DIR | cut -d "=" -f 2)
	#read -p "$brightness_status" < /dev/tty
	if [ brightness_status = false ] ; then
		read -p "$brightness_status" < /dev/tty
		brightnessctl set 100%
		sed -i 's/already100Bright=false/already100Bright=true/' $STATUS_DATA_DIR
	else	
		sed -i 's/already100Bright=true/already100Bright=false/' $STATUS_DATA_DIR
	fi
}

if [ $BATTERY_STATUS = "Charging" ] ; then 
	brightnesstoggle
	if [ $BATTERY_PERCENTAGE -ge 100 ] ; then
		isBatteryFull=$(grep batteryFull $STATUS_DATA_DIR | cut -d "=" -f 2)
		if [ $isBatteryFull = false ] ; then
		dunstify -h string:bgcolor:"#007500" "Battery Full." && paplay ~/Downloads/battery_full.mp3 
		sed -i 's/batteryFull=false/batteryFull=true/' $STATUS_DATA_DIR
		fi	
	else
		sed -i 's/batteryFull=true/batteryFull=false/' $STATUS_DATA_DIR
	fi

	if [ $BATTERY_PERCENTAGE -ge 21 ] ; then
			sed -i 's/notified_for_20_percent=true/notified_for_20_percent=false/' $STATUS_DATA_DIR
	fi
else
	sed -i 's/batteryFull=true/batteryFull=false/' $STATUS_DATA_DIR
	if [ $BATTERY_PERCENTAGE -le 20 ] ; then
		STATUS_DATA=$(grep notified_for_20_percent $STATUS_DATA_DIR | cut -d "=" -f 2)

		if [  $STATUS_DATA = false ] ; then 
			dunstify "Please plug the charger." -u critical && paplay ~/Downloads/please_charge.mp3
			sed -i 's/notified_for_20_percent=false/notified_for_20_percent=true/' ~/.config/sway/status_data
		fi
	fi	
fi

echo $SYSTEM_TEMP\C [$BATTERY_STATUS \($BATTERY_PERCENTAGE\%\)] $DATE_FORMATTED 
