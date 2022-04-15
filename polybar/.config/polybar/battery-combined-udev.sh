#!/bin/sh

battery_print() {
    PATH_AC="/sys/class/power_supply/ACAD"
    PATH_BATTERY_0="/sys/class/power_supply/BAT1"
    PATH_BATTERY_1="/sys/class/power_supply/BAT2"

    ac=0
    battery_level_0=0
    battery_level_1=0
    battery_max_0=0
    battery_max_1=0

    if [ -f "$PATH_AC/online" ]; then
        ac=$(cat "$PATH_AC/online")
    fi

    if [ -f "$PATH_BATTERY_0/energy_now" ]; then
        battery_level_0=$(cat "$PATH_BATTERY_0/energy_now")
    fi

    if [ -f "$PATH_BATTERY_0/energy_full" ]; then
        battery_max_0=$(cat "$PATH_BATTERY_0/energy_full")
    fi

    if [ -f "$PATH_BATTERY_1/energy_now" ]; then
        battery_level_1=$(cat "$PATH_BATTERY_1/energy_now")
    fi

    if [ -f "$PATH_BATTERY_1/energy_full" ]; then
        battery_max_1=$(cat "$PATH_BATTERY_1/energy_full")
    fi

    battery_level=$(("$battery_level_0 + $battery_level_1"))
    battery_max=$(("$battery_max_0 + $battery_max_1"))

    battery_percent=$(("$battery_level * 100"))
    battery_percent=$(("$battery_percent / $battery_max"))

    if ((battery_percent > 80)); then
        icon=
    elif ((battery_percent > 60)); then
        icon=
    elif ((battery_percent > 40)); then
        icon=
    elif ((battery_percent > 20)); then
        icon=
    else
        icon=
    fi

    if [ "$ac" -eq 1 ]; then
        color="%{F#a3be8c}"
        icon=""
    else
        color="%{F#d08770}"

    fi
    echo "${color}$icon %{F-}${battery_percent}%"
}

path_pid="/tmp/polybar-battery-combined-udev.pid"

case "$1" in
    --update)
        pid=$(cat $path_pid)

        if [ "$pid" != "" ]; then
            kill -10 "$pid"
        fi
        ;;
    *)
        echo $$ > $path_pid

        trap exit INT
        trap battery_print USR1

        while true; do
            battery_print

            sleep 30 &
            wait
        done
        ;;
esac
