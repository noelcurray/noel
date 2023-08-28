#!/bin/sh
if [ $XDG_SESSION_TYPE = "wayland" ]; then
	clipboardType=$(wl-paste)
else
	clipboardType=$(xclip -sel clip -o)
fi

mpv $clipboardType & dunstify "MPV" "playing: $clipboardType" -h string:bgcolor:"#8A5B92" -i "/home/noel/.local/share/icons/mpv_logo.svg"


