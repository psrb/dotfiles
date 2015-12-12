dotfiles
========
A collection of my various dotfiles.

## Usage
`./install.sh` creates all necessary links, folders, downloads [vim-plug](https://github.com/junegunn/vim-plug) and installs all Vim plugins.

## Vim

### Configuration

Which plugins will be installed can be controlled on a per-machine basis via the `g:isCompleteInstall` variable.
By default all plugins are installed. The variable can be overwritten in `vim/install_type.vim` (handled by `install.sh`).
An incomplete install ignores some of the heavier plugins which would be not very useful on some machines (e.g. servers).


Filetype specific settings are configured in `vim/after/ftplugin`.
A type of hierarchy is implemented by using `runtime!`.
For example both Markdown (`pandoc.vim`) and LaTex (`tex.vim`) inherit settings from plain text files (`text.vim`) through `runtime! ftplugin/text.vim`.

[YouCompleteMe](https://github.com/Valloric/YouCompleteMe) has a default `vim/ycm_extra_conf.py` that allows auto completion for small `C/C++` projects (or mainly quick tests) without setup.

### Dependencies

- [Base16](https://github.com/chriskempson/base16-builder) terminal colors
- YouCompleteMe: compiled component
- Clang-Format: clang-format
- Tagbar: CTags >= 5.5
- tern_for_vim: npm
- Syntastic: jshint (via npm)
- pandoc

## ZSH

### Configuration

Machine specific environment variables can be put in `~/.zshenv.local`.

