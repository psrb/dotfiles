# vim: fmr={{{,}}} fdm=marker
#
# Description:
#   zshenv: Environment variables
#   zshenv.local: Local additions to environment variables
#   zshrc: Main configuration
#   zsh/completion/: Completion files
#   zsh/modules/: Additional functions/aliases/hashes
#   zsh/site/zshrc.$(uname): System specific settings

# Options {{{

setopt PROMPT_SUBST      # Allow parameter expansion, command substitution in prompt
setopt AUTO_CD           # change dir by just typing the directory name
setopt AUTO_PUSHD        # Push the old directory onto the the directory stack on every cd
setopt PUSHD_IGNORE_DUPS
setopt AUTO_REMOVE_SLASH # Remove slash after completion
setopt ALWAYS_TO_END     # Move cursor to end of word on full completion within word
setopt COMPLETE_IN_WORD
setopt AUTO_LIST
setopt LIST_AMBIGUOUS
setopt NO_FLOW_CONTROL   # Allow the binding of <C-s> and <C-q> which are normally used for flow conrtrol
setopt NO_MENU_COMPLETE  # Don't insert the first match immediately
setopt AUTO_MENU         # Show completion menu
setopt EXTENDED_GLOB

# }}}

# History Options {{{

HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt APPEND_HISTORY         # Append to the history file, don't replace it
setopt INC_APPEND_HISTORY     # Append to history file as soon as possible, not just after a session ends
setopt EXTENDED_HISTORY       # Start timestamp and duration of commands
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicates in the *internal* history first
setopt HIST_IGNORE_ALL_DUPS   # Remove all duplicates of new command
setopt HIST_IGNORE_DUPS       # Don't add command if it is equal to the previous
setopt HIST_IGNORE_SPACE      # Don't add command to history if it starts with a space
setopt HIST_REDUCE_BLANKS     # Normalization for better deduplication
setopt HIST_NO_STORE          # Don't add the history command to the history

# }}}

# Autoloads {{{

autoload -U colors && colors
autoload -U vcs_info

fpath=($HOME/.zsh/completion/ $fpath) # needs to be set before compinit!
autoload -Uz compinit && compinit

# }}}

# Prompt {{{

# configuring version control info in prompt
zstyle ':vcs_info:*' formats '‹%b%u›'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '!'
zstyle ':vcs_info:*' unstagedstr '*'
zstyle ':vcs_info:*' enable git

# call vcs_info before each prompt to update the vcs environment variables
vcs_precmd() {
    vcs_info
}
precmd_functions+=(vcs_precmd)

prompt_user_host_color="$fg[blue]"
if [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_CONNECTION" ]]; then
    prompt_user_host_color="$fg[red]"
fi

local prompt_user_host="%{$prompt_user_host_color%}%n@%m%{$reset_color%}"
local prompt_current_dir="%{$fg[green]%}%~%{$reset_color%}"
local prompt_last_return_code="%{$fg[red]%}%(?..%? )%{$reset_color%}"
local prompt_jobs='%(1j,%j Job%(2j|s|),)' # ternary op (2j meaning here: at least two jobs)

PROMPT='${prompt_user_host} ${prompt_current_dir} %{%F{yellow}%}${vcs_info_msg_0_}%{%f%} ${prompt_jobs}
%{$fg[green]%}❯❯%{$reset_color%} '

RPROMPT='${prompt_last_return_code}'

# }}}

# Completions {{{

zmodload -i zsh/complist # highlighting and scrolling through long completion lists

zstyle ':completion::complete:*' use-cache on
# mather-list: 1. try exatly as written, 2. case-insensitive, 3. partial completion before .,_,-, 4. completion on left sie of written text
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' menu select
zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' verbose yes
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:*:users' ignored-patterns daemon nobody '_*'

# format/colors for kill completion
zstyle ':completion:*:*:kill:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([a-zA-Z]#)*=01;31=0=36'

# }}}

# Keybindings {{{

bindkey -e                                    # use emacs mode instead of vi mode
bindkey -M emacs "^[[Z" reverse-menu-complete # Shift-tab selects backwards in completion menu
bindkey -M emacs "^X?" _complete_debug
bindkey -M emacs "^Xh" _complete_help         # see completion context names, tags and completion functions at current cursor

# use pattern matching in history searches
bindkey -M emacs "^R" history-incremental-pattern-search-backward
bindkey -M emacs "^S" history-incremental-pattern-search-forward

# }}}

# Terminal Title {{{

if [[ "$TERM" == *xterm* ]] || [[ "$TERM" == rxvt* ]]; then

    # Sets the title before showing the prompt
    function title_precmd {
        # display user@host only in ssh sessions
        if [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_CONNECTION" ]]; then
            ssh_prefix='%n@%m: '
        fi

        window_title="${ssh_prefix}%~"
        if [[ $TERM_PROGRAM == Apple_Terminal ]] && [[ -z $INSIDE_EMACS ]]; then
            # from: https://github.com/robbyrussell/oh-my-zsh/blob/master/lib/termsupport.zsh
            #
            # The Apple terminal takes care of displaying the pwd.
            # Bonus feature: New tabs will be openend in the same directory
            local PWD_URL="file://$HOSTNAME${PWD// /%20}"
            print -Pn "\e]7;$PWD_URL\a"
            window_title="$ssh_prefix"
        fi

        # http://www.faqs.org/docs/Linux-mini/Xterm-Title.html#ss3.1
        print -Pn "\e]2;$window_title\a" # Window title
        print -Pn "\e]1;\a" # Clears the title of a tab of

    }
    precmd_functions+=(title_precmd)

    # Sets the title before executing a command.
    # Useful for displaying long running commands (vim, ...).
    # Obviously short commands like 'cd' etc. will also be displayed, which is probaly
    # not desired. The easiest way to not pollute the title with these useless short
    # commands is to clear the tab title on every precmd.
    function title_preexec {
        print -Pn "\e]1;$1\a" # tab title
    }
    preexec_functions+=(title_preexec)
fi

# }}}

# Modules And System Specific Settings {{{

for module in $HOME/.zsh/modules/*.zsh; do
    source $module
done

local system=${$(uname):l}
if [[ -f $HOME/.zsh/site/zshrc.$system ]]; then
    source $HOME/.zsh/site/zshrc.$system
fi
unset system

# }}}

