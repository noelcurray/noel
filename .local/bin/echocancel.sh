
#!/bin/sh

pactl unload-module module-echo-cancel
pactl load-module module-echo-cancel aec_method=webrtc source_name=echocancel sink_name=echocancel1
pactl set-default-source echocancel
pactl set-default-sink echocancel1


