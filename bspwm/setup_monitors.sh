#!/bin/bash

echo "Setting up monitors..."

PRIMARY="eDP1"

# 1. Hitta anslutna skärmar
# Hämta alla aktiva utgångar som en array
CONNECTED=($(xrandr --query | grep " connected" | cut -d" " -f1))

# Filtrera ut externa skärmar (allt utom eDP1)
EXTERNALS=()
for m in "${CONNECTED[@]}"; do
    if [ "$m" != "$PRIMARY" ]; then
        EXTERNALS+=("$m")
    fi
done

# 2. Stäng av frånkopplade skärmar i X11 och bspwm
for m in $(bspc query -M --names); do
    if ! echo "${CONNECTED[@]}" | grep -qw "$m"; then
        # Flytta fönster till laptopskärmen innan vi stänger av
        for n in $(bspc query -N -m "$m"); do
            bspc node "$n" -m "$PRIMARY" -d 1
        done
        bspc monitor "$m" --remove 2>/dev/null
        xrandr --output "$m" --off
    fi
done

# 3. Konfigurera skärmarnas fysiska layout (Vänster - Mitten - Höger)
# eDP1 i mitten
PRIMARY_RES=$(xrandr -q | grep -A 1 "^$PRIMARY " | awk 'NR==2 {print $1}')
xrandr --output "$PRIMARY" --primary --mode "$PRIMARY_RES" --rotate normal

if [ ${#EXTERNALS[@]} -eq 1 ]; then
    # 1 extern skärm: Lägg den till höger (eller ändra till --left-of om du föredrar)
    EXT1="${EXTERNALS[0]}"
    RES1=$(xrandr -q | grep -A 1 "^$EXT1 " | awk 'NR==2 {print $1}')
    xrandr --output "$EXT1" --mode "$RES1" --right-of "$PRIMARY" --rotate normal

elif [ ${#EXTERNALS[@]} -ge 2 ]; then
    # 2 externa skärmar:
    # EXT1 till vänster om laptop
    EXT1="${EXTERNALS[0]}"
    RES1=$(xrandr -q | grep -A 1 "^$EXT1 " | awk 'NR==2 {print $1}')
    xrandr --output "$EXT1" --mode "$RES1" --left-of "$PRIMARY" --rotate normal

    # EXT2 till höger om laptop
    EXT2="${EXTERNALS[1]}"
    RES2=$(xrandr -q | grep -A 1 "^$EXT2 " | awk 'NR==2 {print $1}')
    xrandr --output "$EXT2" --mode "$RES2" --right-of "$PRIMARY" --rotate normal
fi

# 4. Tilldela 4 desktops per skärm rent och direkt
# Först sätter vi temporära unika namn för att undvika namnkrockar
bspc monitor "$PRIMARY" -d "e1" "e2" "e3" "e4"

if [ ${#EXTERNALS[@]} -ge 1 ]; then
    bspc monitor "${EXTERNALS[0]}" -d "ext1_1" "ext1_2" "ext1_3" "ext1_4"
fi
if [ ${#EXTERNALS[@]} -ge 2 ]; then
    bspc monitor "${EXTERNALS[1]}" -d "ext2_1" "ext2_2" "ext2_3" "ext2_4"
fi

# Döpa om till dina riktiga nummer (1-4 på laptop, 5-8 på vänster, 9-12 på höger)
bspc monitor "$PRIMARY" -d 1 2 3 4
if [ ${#EXTERNALS[@]} -ge 1 ]; then
    bspc monitor "${EXTERNALS[0]}" -d 5 6 7 8
fi
if [ ${#EXTERNALS[@]} -ge 2 ]; then
    bspc monitor "${EXTERNALS[1]}" -d 9 10 11 12
fi

# 5. Vänta kort så X11 hinner sätta upp alla fönsterytor
sleep 1

# Starta om Polybar precis som i ditt gamla skript
$HOME/.config/polybar/scripts/launch.sh

# Sätt bakgrundsbild
feh --bg-fill /home/oskar/Pictures/wallpapers/Mountain_Wallpaper.jpg

echo "Monitors ready!"
