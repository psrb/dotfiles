# fzf (fuzzy finder) configuration
#
# https://github.com/junegunn/fzf
if command -v fzf > /dev/null; then
    # auto-completion
    source "$(brew --prefix)/opt/fzf/shell/completion.zsh"

    # key bindings
    source "$(brew --prefix)/opt/fzf/shell/key-bindings.zsh"

    # Use silver search for listing path candidates.
    if command -v ag > /dev/null; then
        _fzf_compgen_path() {
            ag --hidden --ignore .git -g "$1"
        }
    fi

    # Restore CTRL-t normal mapping
    bindkey '\C-t' transpose-chars
fi
