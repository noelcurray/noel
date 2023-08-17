#!/bin/sh

swayidle -w \
	timeout 120 'swaymsg "output * power off" ' resume 'swaymsg "output * power on"'\
	timeout 300 'swaylock -f -c 000000' \

