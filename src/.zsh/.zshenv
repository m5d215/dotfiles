#!/usr/bin/env zsh
#shellcheck shell=bash

. ~/.environment

export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
export FZF_DEFAULT_OPTS='--no-sort --no-mouse --reverse --ansi'
export FPATH=$ZDOTDIR/functions:$FPATH
export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
export PMY_TRIGGER_KEY=^I
