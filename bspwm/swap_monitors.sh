#!/bin/bash
# Växla plats på externa skärmar runt eDP1 (vänster <-> höger)

PRIMARY="eDP1"

# x-position för en utgång, t.ex. "1920x1080+1366+0" -> 1366
xpos() {
    xrandr --query | grep "^$1 connected" | grep -oP '\d+x\d+\+\K\d+'
}

EXTERNALS=($(xrandr --query | grep " connected" | cut -d" " -f1 | grep -v "^$PRIMARY$"))

if [ ${#EXTERNALS[@]} -eq 1 ]; then
    EXT="${EXTERNALS[0]}"
    if [ "$(xpos "$EXT")" -lt "$(xpos "$PRIMARY")" ]; then
        xrandr --output "$EXT" --right-of "$PRIMARY"
    else
        xrandr --output "$EXT" --left-of "$PRIMARY"
    fi
elif [ ${#EXTERNALS[@]} -ge 2 ]; then
    EXT1="${EXTERNALS[0]}"
    EXT2="${EXTERNALS[1]}"
    if [ "$(xpos "$EXT1")" -lt "$(xpos "$EXT2")" ]; then
        LEFT="$EXT2"; RIGHT="$EXT1"
    else
        LEFT="$EXT1"; RIGHT="$EXT2"
    fi
    xrandr --output "$LEFT" --left-of "$PRIMARY" --output "$RIGHT" --right-of "$PRIMARY"
else
    exit 0
fi

sleep 1
$HOME/.config/polybar/scripts/launch.sh
feh --bg-fill /home/oskar/Pictures/wallpapers/Mountain_Wallpaper.jpg
