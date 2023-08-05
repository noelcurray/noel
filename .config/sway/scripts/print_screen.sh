#!/bin/sh
filename=$(date "+%Y%m%d_%R:%S").png
grim -l 0 $filename

dunstify -a "printscreen" -u normal -r 0003 "Print Screen" "file name $filename" 
