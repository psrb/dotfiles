# Hashes
hash -d dotfiles=~/.dotfiles

# General
alias ls="ls -G"
alias l="ls -alh"
alias grep="grep --color=auto"
alias historyall="fc -l 1"

# Git
alias gst="git status"
alias ga="git add"
alias gf="git fetch"
alias gp="git pull"
alias gco="git checkout"
alias gc="git commit"
alias gd="git diff"
alias gdt="git difftool"
alias gll="git log --pretty=\"%C(auto)%h%d %Cred%s%Creset by %an (%cr)\"" # one line: Hash (ref names) Subject by Author (relative date)

# Tmux
alias tmuxa="tmux attach"
alias tmuxls="tmux list-sessions"
alias tmuxksv="tmux kill-server"
alias tmuxkss="tmux kill-session"

alias bell="echo -en '\a'"

