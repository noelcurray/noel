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
read -p  "choose model: (1)Veronica (2)Yoni (3)Marcia (default=All): " model
case $model in
	1)
		ModelDir="/home/noel/Pictures/Proko_models/Veronica_Large/";;
	2)
		ModelDir="/home/noel/Pictures/Proko_models/Yoni_Large/";;
	3)
		ModelDir="/home/noel/Pictures/Proko_models/Marcia_Large/";;
	*)
		ModelDir="/home/noel/Pictures/Proko_models/Veronica_Large/ /home/noel/Pictures/Proko_models/Yoni_Large/ /home/noel/Pictures/Proko_models/Marcia_Large/";
esac
read -p "How many image do you want to draw: " img_count
read -p "image delay (1)30sec (2)1min (3)2min (4)5min (5)custom:" img_delay
case $img_delay in
	1)
		img_delay="30";;
	2)
		img_delay="60";;
	3)
		img_delay="120";;
	4)
		img_delay="300";;
	*)
		read -p "How much time(in seconds) then?: " img_delay;;
esac

declare -i img_count
declare -i img_delay
echo "feh is processing the initial list... please wait.."

imgstart=$(($img_count+1)) # echo "$imgstart" #test kung pumasok yung variable

#create a list of image
shuf -n $img_count /home/noel/Pictures/Proko_models/all_model_pic.txt > /tmp/shuffled_list.txt
#feh --randomize -L %f $ModelDir > /tmp/all_model_pic.txt  ###<--- first attemp to generate. mabagal

#imgend= wc -l /tmp/tmplist.txt | awk '{print $1;}' # para lang malaman yung line count, yung 'awk' command para ma-print lang yung unang word
#echo $end

#echo "trimming the list into " $img_count
##trim down list of images
#sleep 2
#sed -i ''$imgstart',$d' /tmp/tmplist.txt #"$d" means deleted hanggang end
#
echo "running feh.."
#run image viewer 
feh -d -Z --scale-down --filelist /tmp/shuffled_list.txt --on-last-slide quit -z -D $img_delay
#feh -d -Z --scale-down --filelist /tmp/tmplist.txt --on-last-slide quit -z -D $img_delay

echo "here's the list:"
cat /tmp/shuffled_list.txt
