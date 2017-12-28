
function ccd() {
    mkdir -p $1 && cd $1
}

# Colored man pages
# Source: https://wiki.archlinux.org/index.php/Color_output_in_console#man
# LESS_TERMCAP_mb: begin blinking
# LESS_TERMCAP_md: begin bold
# LESS_TERMCAP_me: end mode
# LESS_TERMCAP_se: end standout-mode
# LESS_TERMCAP_so: begin standout-mode - info box
# LESS_TERMCAP_ue: end underline
# LESS_TERMCAP_us: begin underline
# 8-bit color codes: https://en.wikipedia.org/wiki/ANSI_escape_code#8-bit
function man() {
    LESS_TERMCAP_mb=$'\e[1;38;5;1m' \
    LESS_TERMCAP_md=$'\e[1;38;5;1m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[1;38;5;2m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[1;38;5;2m' \
    PAGER=/usr/bin/less \
    command man "$@"
}
