#!/bin/sh

mpv $(xclip -sel clip -o) & dunstify "MPV" "playing: $(xclip -sel clip -o)" -h string:bgcolor:"#4B1F52"


