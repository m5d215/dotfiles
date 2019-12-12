#!/bin/bash

set -e
set -u

ROOT=${ROOT:-~/.ghq/github.com/m5d215/dotfiles}

git clone https://github.com/m5d215/dotfiles.git "$ROOT"

mkdir -p ~/.config
mkdir -p ~/.zsh

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
