#!/bin/bash

set -e
set -u

ROOT=${ROOT:-~/src/github.com/m5d215/dotfiles}

if [ ! -d "$ROOT" ]; then
    git clone https://github.com/m5d215/dotfiles.git "$ROOT"
fi

mkdir -p ~/.config
mkdir -p ~/.pmy
mkdir -p ~/.zsh

function create_link()
{
    local _name
    _name=$1

    if [ -e "$HOME/$_name" ]; then
        mv "$HOME/$_name" "$HOME/$_name.bak"
    fi

    ln -fsv "$ROOT/src/$_name" "$HOME/$_name"
}

create_link .pmy/rules
create_link .pmy/snippets
create_link .zsh/functions
create_link .zsh/.zshrc
create_link bin
create_link .aliases
create_link .bash_profile
create_link .bashrc
create_link .editorconfig2
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
    vim -u <(sed -e '/colorscheme/d' ~/.vimrc) +PlugInstall +qall </dev/null >/dev/null 2>&1
fi
