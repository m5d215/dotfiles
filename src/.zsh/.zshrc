#!/usr/bin/env zsh
#shellcheck shell=bash

# Options
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_no_store
setopt hist_reduce_blanks
setopt share_history
setopt interactivecomments

# history
HISTFILE=$ZDOTDIR/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

function zshaddhistory {
    (( $#1 > 3 ))
}

# zinit
. "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit load hlissner/zsh-autopair
zinit ice from"gh-r" as"command"
zinit load junegunn/fzf-bin
zinit ice from"gh-r" as"command" mv"powerline-go-* -> powerline-go"
zinit load justjanne/powerline-go
zinit load momo-lab/zsh-abbrev-alias
zinit load zsh-users/zsh-autosuggestions
zinit load zsh-users/zsh-completions
zinit load zsh-users/zsh-syntax-highlighting

autoload -U compinit
compinit -C

# powerline
if command -v powerline-go >/dev/null; then
    zmodload zsh/datetime

    function preexec {
        __TIMER=$EPOCHREALTIME
    }

    function powerline_precmd {
        local __ERRCODE=$?
        local __DURATION=0

        if [ -n "$__TIMER" ]; then
            local __ERT=$EPOCHREALTIME
            __DURATION="$((__ERT - ${__TIMER:-__ERT}))"
            __DURATION=${__DURATION%%.*} # floor
            unset __TIMER
        fi

        eval "$(powerline-go \
            -duration $__DURATION \
            -error $__ERRCODE \
            -eval \
            -modules ssh,cwd,perms,jobs,exit \
            -modules-right duration,git \
            -numeric-exit-codes \
            -path-aliases $'\~/src=@GIT,\~/Library/Mobile Documents/com~apple~CloudDocs=@iCloud' \
            -shell zsh \
        )"
    }

    function install_powerline_precmd {
        for s in "${precmd_functions[@]}"
        do
            if [ "$s" = "powerline_precmd" ]; then
                return
            fi
        done
        precmd_functions+=(powerline_precmd)
    }

    if [ "$TERM" != "linux" ]; then
        install_powerline_precmd
    fi
fi

. ~/.aliases

# pmy
if command -v pmy >/dev/null; then
    eval "$(pmy init)"
fi

# key binding
autoload -Uz cd-home
autoload -Uz cd-up
autoload -Uz docker-fuzzy-container
autoload -Uz docker-fuzzy-image
autoload -Uz git-fuzzy-branch
autoload -Uz git-fuzzy-log
autoload -Uz git-fuzzy-work-tree
autoload -Uz fuzzy-history
autoload -Uz replace-command
autoload -Uz ls-now
autoload -Uz unpipe
zle -N cd-home
zle -N cd-up
zle -N docker-fuzzy-container
zle -N docker-fuzzy-image
zle -N git-fuzzy-branch
zle -N git-fuzzy-log
zle -N git-fuzzy-work-tree
zle -N fuzzy-history
zle -N replace-command
zle -N ls-now
zle -N unpipe
bindkey '^[^' cd-home
bindkey '^^' cd-up
bindkey '^e^v' docker-fuzzy-container
bindkey '^e^i' docker-fuzzy-image
bindkey '^g^r' git-fuzzy-branch
bindkey '^g^g' git-fuzzy-log
bindkey '^g^w' git-fuzzy-work-tree
bindkey '^r' fuzzy-history
bindkey '^e^r' replace-command
bindkey '^e^l' ls-now
bindkey '^|' unpipe
