#!/bin/bash

echo "Setting up monitors..."

for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do        
    OPTIONS=$(xrandr --query | grep $m | cut -d" " -f1,3,4 | cut -d"+" -f1)
    echo "MONITOR: " $(xrandr --query | grep $m)
    
    RES=$(xrandr -q | grep -A 1 $m | awk 'NR==2 {print $1}')
    echo "RES: "$RES
    
    if [ "$(xrandr -q | grep $m | grep primary | cut -d" " -f3)" = "primary" ]; then
        echo ">>>PRIMARY<<<"
        xrandr --output $m --primary --mode $RES --rotate normal
        bspc monitor $m -d I II III IV
    else
        xrandr --output $m --auto --left-of $(xrandr -q | grep primary | cut -d" " -f1) --mode $RES --rotate normal
        
        # Auto-increment desktop numbers
        HIGHEST_DESKTOP=$(bspc query -D | sort -n | tail -1)
        START_NUM=$((HIGHEST_DESKTOP + 1))

        echo "Adding desktops $START_NUM to $((START_NUM+3)) on monitor $m"
        bspc monitor $m -d $START_NUM $((START_NUM+1)) $((START_NUM+2)) $((START_NUM+3))
    fi
done

sleep 1

# Restart polybar
$HOME/.config/polybar/scripts/launch.sh

# Refresh background
feh --bg-fill /home/oskar/Pictures/wallpapers/Mountain_Wallpaper.jpg
