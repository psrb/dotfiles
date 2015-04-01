dotfiles
========
A collection of my various dotfiles.

## Usage
`./install.sh` creates all necessary links, folders, downloads [vim-plug](https://github.com/junegunn/vim-plug) and installs all Vim plugins.

Which Vim plugins will be installed can be controlled on a per-machine basis via the `g:isCompleteInstall` variable.
By default all plugins are installed. The variable can be overwritten in `vim/install_type.vim` (handled by `install.sh`).

## Dependencies

- YouCompleteMe: compiled component
- Clang-Format: clang-format
- Tagbar: CTags >= 5.5
- tern_for_vim: npm
- Syntastic: jshint (via npm)
- pandoc
