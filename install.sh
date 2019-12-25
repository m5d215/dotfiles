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

ln -fsv "$ROOT"/src/.pmy/rules        ~/.pmy/rules
ln -fsv "$ROOT"/src/.pmy/snippets     ~/.pmy/snippets
ln -fsv "$ROOT"/src/.zsh/functions    ~/.zsh/functions
ln -fsv "$ROOT"/src/.zsh/.zshrc       ~/.zsh/.zshrc
ln -fsv "$ROOT"/src/bin               ~/bin
ln -fsv "$ROOT"/src/.aliases          ~/.aliases
ln -fsv "$ROOT"/src/.bash_profile     ~/.bash_profile
ln -fsv "$ROOT"/src/.bashrc           ~/.bashrc
ln -fsv "$ROOT"/src/.editorconfig2    ~/.editorconfig
ln -fsv "$ROOT"/src/.environment      ~/.environment
ln -fsv "$ROOT"/src/.gitconfig        ~/.gitconfig
ln -fsv "$ROOT"/src/.tmux.conf        ~/.tmux.conf
ln -fsv "$ROOT"/src/.vimrc            ~/.vimrc
ln -fsv "$ROOT"/src/.zshenv           ~/.zshenv
