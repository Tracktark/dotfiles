# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored
zstyle :compinstall filename '/home/moss/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt autocd
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install


# PATH
path+=('/home/moss/.local/bin')
path+=('/home/moss/.emacs.d/bin')
path+=('/home/moss/go/bin/')
path+=('/home/moss/.nimble/bin')
path+=('/home/moss/.local/share/gem/ruby/3.0.0/bin')
export PATH

export PICO_SDK_PATH="/home/moss/projects/pico/pico-sdk"
export GOPATH="$HOME/go"
export ANDROID_HOME="/opt/android-sdk"

dbus-update-activation-environment --systemd --all >/dev/null 2>&1 

# BW session key gen
alias bw="bw_session"

# ALIASES
alias ls="ls --color=auto -h"
alias la="ls -la"
alias l="ls -l"

alias mkdir="mkdir -p"
alias df="df -h"
alias du="du -h"
alias dus="du --summarize"
alias cal="cal -m"
alias ipy="ipython"
alias bat="bat -p"

alias sds="systemctl status"
alias sdr="systemctl restart"
alias sus="systemctl --user status"
alias sur="systemctl --user restart"

alias zshconf="em ~/.zshrc"
alias i3conf="em ~/.config/i3/config"
alias xconf="em ~/.xinitrc"
alias hostname="cat /etc/hostname"


PROMPT=$'%(?..%F{red}%?%f )%B%2~%b %# '

# Emacs vterm shell side config
vterm_printf() {
    if [ -n "$TMUX" ] && ([ "${TERM%%-*}" = "tmux" ] || [ "${TERM%%-*}" = "screen" ]); then
        printf "\ePtmux;\e\e]%s\007\e\\" "$1"
    elif [ "${TERM%%-*}" = "screen" ]; then
        printf "\eP\e]%s\007\e\\" "$1"
    else
        printf "\e]%s\e\\" "$1"
    fi
}

vterm_prompt_end() {
    vterm_printf "51;A$(whoami)@$(hostname):$(pwd)";
}
vterm_cmd() {
    local vterm_elisp
    vterm_elisp=""
    while [ $# -gt 0 ]; do
        vterm_elisp="$vterm_elisp""$(printf '"%s" ' "$(printf "%s" "$1" | sed -e 's|\\|\\\\|g' -e 's|"|\\"|g')")"
        shift
    done
    vterm_printf "51;E$vterm_elisp"
}

if [[ "$INSIDE_EMACS" == 'vterm' ]]; then
    alias man="vterm_cmd man"
    setopt PROMPT_SUBST
    PROMPT=$PROMPT'%{$(vterm_prompt_end)%}'
    [ -z "$TMUX" ] && exec tmux
    true
fi
