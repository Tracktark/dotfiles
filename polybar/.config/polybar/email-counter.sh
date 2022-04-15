#!/bin/zsh

last_notif=$(date +%s)

get_count() {
    if result=$(mu find "flag:unread AND NOT flag:trashed" 2>/dev/null); then
        echo "%{F#f2d937}%{F-} $(echo $result | wc -l)"
    else
        echo
    fi
    mu find --after ${last_notif} --fields $'f - s' "flag:unread AND NOT flag:trashed" 2>/dev/null | while read -r line; do
        dunstify -a "mail" "New Mail" "${line}"
    done
    last_notif=$(date +%s)
}

if [[ $1 == "--update" ]]; then
    trap exit USR1
    pkill -USR1 email-counter &> /dev/null
fi

trap exit INT
trap get_count USR1

while true; do
    get_count
    sleep 30 &
    wait
done
