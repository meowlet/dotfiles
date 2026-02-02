# Initialize Starship prompt
eval "$(starship init zsh)"

# Set terminal window title
function set_win_title() {
    echo -ne "\033]0;${USER}@$(hostname -s):${PWD}\007"
}

precmd_functions+=(set_win_title)
