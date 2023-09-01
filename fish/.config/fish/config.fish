if status is-interactive
	
end

fish_add_path /home/moss/.spicetify

bind \e\[3\;5~ 'kill-word'
bind \b 'backward-kill-word'

starship init fish | source

abbr -a -- sur 'systemctl --user restart'
abbr -a -- ju 'journalctl --user -f -u'
abbr -a -- awlog 'tail -f ~/.local/share/awesome/stdout'
abbr -a -- sus 'systemctl --user status'
abbr -a -- dcd 'docker compose --profile dev'

set -g VIRTUALFISH_HOME ~/.local/share/venvs
