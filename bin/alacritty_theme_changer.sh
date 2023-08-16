#!/bin/sh
	##test variable
	#echo "test_var is: $test_var"
	#read -p "" >/dev/null	

#fills up the array with themes
files=($(ls .config/alacritty/themes/themes/* -f -d))

#get the current theme
#current_theme=$(cat .config/alacritty/alacritty.yml | grep -| tr -d '-')
#current_theme=$(cat .config/alacritty/alacritty.yml | grep -| cut -c 7-)
current_theme=$(cat .config/alacritty/alacritty.yml | grep -| cut -d "/" -f 6)
hold_current_theme=$(echo $current_theme)
current_theme_position=0
replacement_theme_position=0
theme_count=$(echo ${#files[@]})

#search in the $files which number is the current theme-------------------------------
for (( i=0; i<=$theme_count; i++ ))
do
	test_var=$(echo ${files[$i]} | cut -d "/" -f 5)
	
	if [ $test_var = $current_theme ] ; then
		current_theme_position=$(echo $i)
		hold_current_theme=$(echo ${files[$i]})
		break
	fi
done
#--------------------------------------------------------------------------------------
SEARCH_REGEX=$(echo ${files[$current_theme_position]})

case $1 in
	next)
		replacement_theme_position=$(($current_theme_position+1))
		if [ $replacement_theme_position -ge $theme_count ] ; then
			replacement_theme_position=0
		fi
		
		REPLACEMENT=$(echo ${files[$replacement_theme_position]})
		sed -i 's|'"$SEARCH_REGEX"'|'"$REPLACEMENT"'|g' .config/alacritty/alacritty.yml
		dunstify -r 0005 "Alacritty theme:" "[$replacement_theme_position]$(echo $REPLACEMENT|cut -d "/" -f 5)"
		;;
	previous)
		replacement_theme_position=$(($current_theme_position-1))
		if [ $replacement_theme_position -le 0 ] ; then
			replacement_theme_position=$(echo $theme_count)
		fi
		
		REPLACEMENT=$(echo ${files[$replacement_theme_position]})
		sed -i 's|'"$SEARCH_REGEX"'|'"$REPLACEMENT"'|g' .config/alacritty/alacritty.yml
		dunstify -r 0005 "Alacritty theme:" "[$replacement_theme_position]$(echo $REPLACEMENT|cut -d "/" -f 5)"
		;;
	*)
		dunstify -r 0005 "add Next or Previous"
esac	

