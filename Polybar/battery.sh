#!/bin/sh

PATH_AC="/sys/class/power_supply/ADP0/"
PATH_BATTERY_0="/sys/class/power_supply/BAT0"

ac=0
battery_level=0
battery_max=0

if [ -f "$PATH_AC/online" ]; then
	ac=$(cat "$PATH_AC/online")
fi

if [ -f "$PATH_BATTERY_0/energy_now" ]; then
	battery_level=$(cat "$PATH_BATTERY_0/energy_now")
fi

if [ -f "$PATH_BATTERY_0/energy_full" ]; then
	battery_max=$(cat "$PATH_BATTERY_0/energy_full")
fi

battery_percent=$(($battery_level * 100))
battery_percent=$(($battery_percent / $battery_max))

if [ "$ac" -eq 1 ]; then
	echo "+$battery_percent%"
else
	echo "$battery_percent%"
fi
