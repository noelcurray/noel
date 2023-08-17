#! /bin/sh
rtcwake --mode disk --local --time $(date +\%s -d "tomorrow 06:00")
