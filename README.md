dotfiles
========
A collection of my various dotfiles.

## Usage
`./install.sh` downloads oh-my-zsh and vundle, creates all necessary symlinks and folders and installs the plugins for Vim.

If the environment variable `VIM_LIGHT_INSTALL` is set some Vim plugins will not be installed.

## Dependencies
 - YouCompleteMe: clang, needs to be compiled
 - Clang-Format: clang-format
 - Tagbar: CTags >= 5.5
