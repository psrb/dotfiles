
function ccd() {
    mkdir -p $1 && cd $1
}

# Colored man pages
# Source: https://linuxtidbits.wordpress.com/2009/03/23/less-colors-for-man-pages/
# LESS_TERMCAP_mb: begin blinking
# LESS_TERMCAP_md: begin bold
# LESS_TERMCAP_me: end mode
# LESS_TERMCAP_se: end standout-mode
# LESS_TERMCAP_so: begin standout-mode - info box
# LESS_TERMCAP_ue: end underline
# LESS_TERMCAP_us: begin underline
function man() {
    env \
    LESS_TERMCAP_mb=$'\e[1;31m' \
    LESS_TERMCAP_md=$'\e[1;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[1;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[1;32m' \
    PAGER=/usr/bin/less \
    man "$@"
}
