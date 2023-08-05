#!/bin/bash


notify_plug=true
notify_bat_full=false
brightness_100=false

function brightnesstoggle() {
	#read -p "$brightness_status" < /dev/tty
	if [ brightness_100 = false ] ; then
		brightnessctl set 100%
		brightness_100=true
	else
		brightness_100=false
	fi
}

function battery_checker() {
	date_display=$(date +'%Y-%m-%d %T')
	batt_stat=$(cat /sys/class/power_supply/BAT0/status)
	batt_cap=$(cat /sys/class/power_supply/BAT0/capacity)
	sys_temp=$(acpi -t | cut -d " " -f 4)

      if [ $batt_stat = "Charging" ] ; then 
      	if [ $batt_cap -ge 100 ] ; then
      		if [ $notify_bat_full = false ] ; then
      			dunstify -h string:bgcolor:"#007500" "Battery Full." && paplay ~/Downloads/battery_full.mp3
      			notify_bat_full=true
      		fi 
      	else
      		notify_bat_full=false
      	fi
      		
	if [ $batt_cap -ge 21 ] ; then notify_plug=false ; fi

      else
      	notify_bat_full=false
      	if [ $batt_cap -le 20 ] ; then
      		if [ notify_plug = false ] ; then
      			dunstify "Please plug the charger." -u critical && paplay ~/Downloads/please_charge.mp3
      			notify_plug=true
      		fi
      	fi
      	
      fi

	echo $sys_temp°C [$batt_stat \($batt_cap\%\)] $date_display 
}

while true 
do
	battery_checker
	sleep 1
done

