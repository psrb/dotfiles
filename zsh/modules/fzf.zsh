# fzf (fuzzy finder) configuration
#
# https://github.com/junegunn/fzf
if command -v fzf > /dev/null; then
    # auto-completion
    [[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.zsh" 2> /dev/null

    # key bindings
    source "/usr/local/opt/fzf/shell/key-bindings.zsh"

    # Use silver search for listing path candidates.
    if command -v ag > /dev/null; then
        _fzf_compgen_path() {
            ag --hidden --ignore .git -g "$1"
        }
    fi
fi
