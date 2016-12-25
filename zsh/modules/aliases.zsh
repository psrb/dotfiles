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
alias gc="git commit"
alias gd="git diff"
alias gdt="git difftool"
alias gll="git log --pretty=\"%C(auto)%h %Cred%s%Creset by %an (%cr)\"" # online: Hash Subject by Author (relative date)

# Tmux
alias tmuxa="tmux attach"
alias tmuxls="tmux list-sessions"
alias tmuxksv="tmux kill-server"
alias tmuxkss="tmux kill-session"

alias bell="echo -en '\a'"

