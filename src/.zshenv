#!/usr/bin/env zsh
#shellcheck shell=bash

if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

export ZDOTDIR=$HOME/.zsh
source "$ZDOTDIR/.zshenv"
