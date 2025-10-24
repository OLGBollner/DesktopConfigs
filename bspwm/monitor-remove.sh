#!/bin/bash

echo "Cleaning up disconnected monitors..."

PRIMARY=$(xrandr -q | grep primary | cut -d" " -f1)    

if [ $(bspc query -M | wc -l) -eq 1 ]; then
    bspc monitor $PRIMARY -d I II III IV
else
    TARGET_DESKTOP=$(bspc query -D -m $PRIMARY | head -n 1)
    for m in $(xrandr --query | grep " disconnected" | cut -d" " -f1); do
        for d in $(bspc query -D -m $m); do
            for n in $(bspc query -N -d $d); do
                bspc node $n -m $PRIMARY -d $TARGET_DESKTOP
            done
            bspc desktop $d --remove
        done
        bspc monitor $m --remove
        xrandr --output $m --off
    done

    RES=$(xrandr -q | grep -A 1 $PRIMARY | awk 'NR==2 {print $1}')
    xrandr --output $PRIMARY --primary --mode $RES --rotate normal
fi

sleep 1

# Restart polybar
$HOME/.config/polybar/scripts/launch.sh

# Refresh background
feh --bg-fill /home/oskar/Pictures/wallpapers/Mountain_Wallpaper.jpg
