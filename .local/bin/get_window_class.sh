#!/bin/sh

var1=`xprop | grep WM_CLASS | awk '{ print $4 }'`

dunstify $var1
