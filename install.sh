#!/bin/bash

set -euo pipefail

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

create_link() {
    local _src
    local _dest
    _src=$1
    _dest=${2:-$1}

    ln -fsnv "$ROOT/src/$_src" "$HOME/$_dest"
}

create_link .config/git
create_link .config/zabrze
create_link .zsh/functions
create_link .zsh/.zshenv
create_link .zsh/.zshrc
create_link bin
create_link .bash_profile
create_link .bashrc
create_link .editorconfig4 .editorconfig
create_link .tmux.conf
create_link .vimrc
create_link .zshenv

# Install Tmux Plugin Manager
if [ ! -d ~/.tmux/plugins/tpm ]; then
    git clone https://github.com/tmux-plugins/tpm.git ~/.tmux/plugins/tpm
fi

# Install vim-plug
if [ ! -f ~/.vim/autoload/plug.vim ]; then
    curl -fsSL https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim -o ~/.vim/autoload/plug.vim --create-dirs
    vimrc_tmp=$(mktemp "${TMPDIR:-/tmp}/vimrc.XXXXXX")
    trap 'rm -f "$vimrc_tmp"' EXIT
    sed -e '/colorscheme/d' ~/.vimrc >"$vimrc_tmp"
    vim -u "$vimrc_tmp" +PlugInstall +qall </dev/null >/dev/null 2>&1
    rm -f "$vimrc_tmp"
fi
