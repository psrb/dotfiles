#!/bin/sh

ask() {
    printf "%s [yN]: " "$1"
    read -r yn
    if [ "$yn" = "y" ] || [ "$yn" = "Y" ]; then
        return 0
    fi
    return 1
}

check_installed() {
    printf " %s: " "$1"
    if command -v "$1" >/dev/null 2>&1; then
        echo "installed!"
    else
        echo "not installed!"
        exit 1
    fi
}

# Create a link named $2 to file $1.
# Overwrites existing links.
# Overwrites all other files only on user confirmation
create_link() {
    file=$1
    link_name=$2

    printf " Link: %s -> %s\n" "$link_name" "$file"

    if [ -h "$link_name" ]; then # is a symbolic link
        rm "$link_name"
    elif [ -e "$link_name" ]; then # other file exists
        if ask " File \"$link_name\" exists! Do you want to overwrite it? "; then
            if [ -d "$link_name" ]; then
                rm -r "$link_name"
            else
                rm "$link_name"
            fi
        else
            return
        fi
    fi

    ln -s "$file" "$link_name"
}

download_plug_vim() {
    file_path=$1

    echo "Downloading plug.vim"
    printf " "
    if [ -e "$file_path" ]; then
        echo "Already downloaded!"
        return
    fi

    if curl -sfLo "$file_path" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim;
    then
        echo "Downloaded!"
    else
        echo "Failed!"
        exit 1
    fi
}

##### MAIN #####

echo "Checking installs"
check_installed vim
check_installed zsh
check_installed git
echo

SCRIPT_DIR=$(cd "$(dirname "$0")" || exit 1; pwd)

echo "Creating links"
create_link "$SCRIPT_DIR/latexmkrc" ~/.latexmkrc
create_link "$SCRIPT_DIR/tmux.conf" ~/.tmux.conf
create_link "$SCRIPT_DIR/vim" ~/.vim
create_link "$SCRIPT_DIR/zsh" ~/.zsh
create_link "$SCRIPT_DIR/zsh/zprofile" ~/.zprofile
create_link "$SCRIPT_DIR/zsh/zshenv" ~/.zshenv
create_link "$SCRIPT_DIR/zsh/zshrc" ~/.zshrc

if [ "$(uname)" = "Darwin" ]
then
    create_link "$SCRIPT_DIR/hammerspoon" ~/.hammerspoon
fi
echo

echo "Creating folders"
echo " Folder: ~/.vimundo"
[ ! -d ~/.vimundo ] && mkdir ~/.vimundo
echo

echo "Installing ZSH completions"

if [ ! -d "$SCRIPT_DIR/zsh/completion/zsh-completions" ]
then
    git clone https://github.com/zsh-users/zsh-completions \
        "$SCRIPT_DIR/zsh/completion/zsh-completions"
else
    echo " Already cloned!"
fi
echo

download_plug_vim "$SCRIPT_DIR/vim/autoload/plug.vim"
echo

echo "Installing Vim plugins"

vim_install_type_path=vim/autoload/installType.vim
if [ ! -e  $vim_install_type_path ]; then
    if ask " Install all vim plugins?"; then
        echo "let g:installType#isCompleteInstall = 1" > $vim_install_type_path
    else
        echo "let g:installType#isCompleteInstall = 0" > $vim_install_type_path
    fi
fi
vim +PlugInstall +sleep4 +qa
echo " Done!"
echo

echo "Finished!"

