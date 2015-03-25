#!/bin/sh

command -v vim >/dev/null 2>&1
VIM_INSTALLED=$?
if [ $VIM_INSTALLED -ne 0 ]; then
    printf "Vim is not installed.\n"
    exit 1
fi

printf "Cloning oh-my-zsh ...\t"
if [ ! -d oh-my-zsh ]; then
    printf "\n"
    git clone git://github.com/robbyrussell/oh-my-zsh.git oh-my-zsh
    printf "\n"
else
    printf "already installed!\n"
fi

printf "Cloning plug.vim    ...\t"
if [ ! -f vim/autoload/plug.vim ]; then
    printf "\n"
    curl -fLo vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    printf "\n"
else
    printf "already installed!\n"
fi

printf "Creating folders\n"
[ ! -d ~/.vimundo ] && mkdir ~/.vimundo

printf "Creating symlinks\n"
SCRIPT_DIR=$(cd $(dirname $0); pwd)
[ ! -h ~/.tmux.conf ] && ln -s $SCRIPT_DIR/tmux.conf ~/.tmux.conf
[ ! -h ~/.vim ] && ln -s $SCRIPT_DIR/vim ~/.vim
[ ! -h ~/.vimrc ] && ln -s $SCRIPT_DIR/vimrc ~/.vimrc
[ ! -h ~/.oh-my-zsh ] && ln -s $SCRIPT_DIR/oh-my-zsh ~/.oh-my-zsh
[ ! -h ~/.zshenv ] && ln -s $SCRIPT_DIR/zshenv ~/.zshenv
[ ! -h ~/.zshrc ] && ln -s $SCRIPT_DIR/zshrc ~/.zshrc

printf "Installing Vim plugins\n"

read -p "Light install (less plugins)? [yN]:" yn
if [ "$yn" = "y" ] || [ "$yn" = "Y" ]; then
    echo "Remember to export the environment variable 'VIM_LIGHT_INSTALL'!"
    export VIM_LIGHT_INSTALL=1
fi
vim +PlugInstall

printf "Finished\n"

