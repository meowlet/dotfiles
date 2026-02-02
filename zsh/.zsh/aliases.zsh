# File listing with eza
alias ls="eza --icons --grid --group-directories-first"
alias ll="eza --icons --long --git --group-directories-first"
alias la="eza --icons --long --git --group-directories-first --all"
alias tree="eza --icons --tree"

# Better cat with syntax highlighting
alias cat="bat"

# Navigation shortcuts
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Git shortcuts
alias g="git"
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git pull"
alias gd="git diff"
alias gco="git checkout"
alias gb="git branch"
alias glog="git log --oneline --graph --decorate"
