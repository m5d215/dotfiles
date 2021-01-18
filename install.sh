#!/bin/bash

set -e
set -u

: docker container run --rm -it -v "$PWD:$PWD":ro -w "$PWD" alpine:3 sh -c '
    apk --no-cache add bash curl git vim
    ./install.sh
    ls -Al ~
'

ROOT=${ROOT:-~/src/github.com/m5d215/dotfiles}

if [ ! -d "$ROOT" ]; then
    git clone https://github.com/m5d215/dotfiles.git "$ROOT"
fi

mkdir -p ~/.config
mkdir -p ~/.zsh

function create_link {
    local _src
    local _dest
    _src=$1
    _dest=${2:-$1}

    if [ -e "$HOME/$_dest" ] && [ ! -s "$HOME/$_dest" ]; then
        mkdir -p "$HOME/.dotfiles-backup"
        mv "$HOME/$_dest" "$HOME/.dotfiles-backup/$_dest"
    fi

    rm -f "$HOME/$_dest"
    ln -fsv "$ROOT/src/$_src" "$HOME/$_dest"
}

create_link .pmy
create_link .zsh/functions
create_link .zsh/.zshenv
create_link .zsh/.zshrc
create_link bin
create_link .aliases
create_link .bash_profile
create_link .bashrc
create_link .editorconfig2 .editorconfig
create_link .environment
create_link .gitconfig
create_link .tmux.conf
create_link .vimrc
create_link .zshenv

# Install zinit
if [ ! -d ~/.zinit/bin ]; then
    git clone https://github.com/zdharma/zinit.git ~/.zinit/bin
fi

# Install Tmux Plugin Manager
if [ ! -d ~/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm.git ~/.tmux/plugins/tpm
fi

# Install vim-plug
if [ ! -f ~/.vim/autoload/plug.vim ]; then
    curl -fsSL https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -o ~/.vim/autoload/plug.vim --create-dirs
    sed -e '/colorscheme/d' ~/.vimrc >/tmp/.vimrc_deleteme
    vim -u /tmp/.vimrc_deleteme +PlugInstall +qall </dev/null >/dev/null 2>&1
    rm /tmp/.vimrc_deleteme
fi
