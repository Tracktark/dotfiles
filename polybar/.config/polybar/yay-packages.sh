#!/bin/zsh

if ! updates=$(yay -Qum 2> /dev/null | wc -l); then
    updates=0
fi

if [ "$updates" -gt 0 ]; then
    echo "%{T3}%{F#ebcb8b}%{F-}%{T-} $updates"
else
    echo ""
fi
