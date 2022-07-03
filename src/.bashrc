#!/usr/bin/env bash

[ -z "$PS1" ] && return

# environment
export PS4='\033[90m+${BASH_SOURCE##*/}:${LINENO}: ${FUNCNAME:+$FUNCNAME: }\033[0m'

# windows
if [ "$OSTYPE" == 'msys' ]; then
    # prompt
    export PS1='\[\e[36m\]WINDOWS \[\e[33m\]\w\[\e[36m\]`__git_ps1`\[\e[0m\] $ '
    [ "$(pwd)" == / ] && cd ~

    # colorscheme
    if [ ! -d ~/src/github.com/sonatard/terminal-color-theme ]; then
        git clone --recurse-submodules https://github.com/sonatard/terminal-color-theme.git ~/src/github.com/sonatard/terminal-color-theme
    fi
    source ~/src/github.com/sonatard/terminal-color-theme/color-theme-molokai/molokai.sh
fi

# powerline-go
if command -v powerline-go >/dev/null; then
    function _update_prompt {
        eval "$(powerline-go \
            -error $? \
            -eval \
            -modules ssh,cwd,perms,jobs,exit \
            -modules-right git \
            -numeric-exit-codes \
            -shell bash \
        )"
    }

    PROMPT_COMMAND="_update_prompt; $PROMPT_COMMAND"
fi

# abbrev-alias
if [ ! -d ~/src/github.com/momo-lab/bash-abbrev-alias ]; then
    git clone https://github.com/momo-lab/bash-abbrev-alias.git ~/src/github.com/momo-lab/bash-abbrev-alias
fi
source ~/src/github.com/momo-lab/bash-abbrev-alias/abbrev-alias.plugin.bash

# completion
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
