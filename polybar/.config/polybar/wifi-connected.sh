#!/bin/zsh

color="b48ead"
ip_print=0

switch() {
    if [[ $ip_print == 0 ]]; then
        ip_print=1
    else
        ip_print=0
    fi
    wifi_print
}

wifi_print() {
    state=$(nmcli -g GENERAL.STATE device show wlp3s0)

    if [[ $state =~ "\(connected\)" ]]; then
        if [[ $ip_print == 1 ]]; then
            essid=$(nmcli -g GENERAL.CONNECTION device show wlp3s0)
            ip=$(ip a show wlp3s0 | grep "inet " | awk '{print $2}' | cut -d'/' -f1 )
            label=" $essid ($ip)"
        else
            label=""
        fi

        # Get signal strength
        strength=$(iw dev wlp3s0 station dump | grep "signal avg" | awk '{print $3; exit}')
        if (( $strength > -50 )); then
            main_icon=""
            sec_icon="􏇫"
        elif (( $strength > -70 )); then
            main_icon=""
            sec_icon="􏚫"
        else
            main_icon=""
            sec_icon="􏚪"
        fi
            # main_icon=""
            # sec_icon="􏇫"
        echo "%{T4}%{F#$color}$main_icon%{F#40$color}%{O-19}$sec_icon%{T-}%{F-}$label"
    else
        echo
    fi

}

trap switch USR1

while true; do
    wifi_print
    sleep 3 &
    wait
done
