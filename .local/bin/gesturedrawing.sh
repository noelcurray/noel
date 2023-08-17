#!/bin/sh
#
## first code ko para sa random image para sa sway 
## -------------------------------------------
##MYPICTURE=`find ~/Pictures/Women -type f | shuf -n 1`
##echo $MYPICTURE
##imv $MYPICTURE
#
#
#feh -Z --draw-filename --randomize --scale-down --slideshow-delay 120 ~/Pictures/Proko_models/Veronica_Large --filelist /tmp/tmplist
#
echo "__PROKO MODEL IMAGE SLIDESHOW SCRIPT__"
echo "::choose model: "
echo " 1)All Models 2)Veronica 3)Yoni 4)Marcia "
read -p  "enter a number (default=1): " model

case $model in
	2)
		ModelDir="Veronica_Large";;
	3)
		ModelDir="Yoni_Large";;
	4)
		ModelDir="Marcia_Large";;
	*)
		echo "You choose all models"
		ModelDir="Veronica|Yoni|Marcia";;
		
esac

echo "::How many image do you want to draw?"
read -p "enter a number: " img_count
#case $img_count in
#	2)
#		img_count="5";;
#	3)
#		img_count="10";;
#	4)
#		img_count="20";;
#	*)
#		read -p "enter image count: " img_count;;
#esac

read -p "enter seconds: " img_delay

declare -i img_count
declare -i img_delay

read -p "press Enter to proceed.." </dev/tty
#for ((k = 0; k <= 10 ; k++))
#do
#    echo -n "[ "
#    	for ((i = 0 ; i <= k; i++)); do echo -n "###"; 
#	done
#    	
#	for ((j = i ; j <= 10 ; j++)); do echo -n "   "; 
#	done
#    v=$((k * 10))
#    echo -n " ] "
#    echo -n "$v %" $'\r'
#    sleep 1
#done
#echo

#run image viewer
grep -E "$ModelDir" /home/noel/Pictures/Proko_models/all_model_pic.txt | shuf -n $img_count > /tmp/shuffled_list.txt

feh --filelist /tmp/shuffled_list.txt --slideshow-delay $img_delay --geometry 640x480 --on-last-slide quit --auto-zoom --scale-down

echo "here's the list:"
cat /tmp/shuffled_list.txt
rm /tmp/shuffled_list.txt
