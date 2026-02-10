#!/usr/bin/env zsh
#shellcheck shell=bash

# Options
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_no_store
setopt hist_reduce_blanks
setopt share_history
setopt interactivecomments
setopt extended_glob

# history
HISTFILE=$ZDOTDIR/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

function zshaddhistory {
    (( $#1 > 3 )) || return 1
    ! [[ "$1" =~ ^\./ ]] || return 1
    ! [[ "$1" =~ ^(eza|ls) ]] || return 1
}

# command_not_found_handler
if command -v docker >/dev/null && ! command -v pokemonsay >/dev/null; then
    function pokemonsay {
        docker run --rm -it xaviervia/pokemonsay --no-name --think "$@"
    }
fi

if command -v pokemonsay >/dev/null; then
    function command_not_found_handler {
        pokemonsay "command '$1' not found" 2>/dev/null
        return 127
    }
fi

# ZI
typeset -A ZI
ZI[BIN_DIR]=~/.zi/bin

if [ ! -d "$ZI[BIN_DIR]" ]; then
    git clone https://github.com/z-shell/zi.git "$ZI[BIN_DIR]"
fi

source "${ZI[BIN_DIR]}/zi.zsh"

autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi

zi light z-shell/z-a-bin-gem-node

zi ice from'gh-r' as'command' mv'bat* bat' sbin'**/bat(.exe|) -> bat'
zi light @sharkdp/bat

zi ice from'gh-r' as'command' mv'fd* fd' sbin'**/fd(.exe|) -> fd'
zi light @sharkdp/fd

zi ice from'gh-r' as'command'
zi light junegunn/fzf

zi ice from'gh-r' as'command' mv'hyperfine* hyperfine' sbin'**/hyperfine(.exe|) -> hyperfine'
zi light @sharkdp/hyperfine

zi ice from'gh-r' as'command' cp'powerline-go-* -> powerline-go'
zi light justjanne/powerline-go

zi wait lucid for \
    atinit'ZI[COMPINIT_OPTS]=-C; zicompinit; zicdreplay' \
        z-shell/F-Sy-H \
    blockf \
        zsh-users/zsh-completions \
    atload'!_zsh_autosuggest_start' \
        zsh-users/zsh-autosuggestions

zi ice wait lucid
zi light hlissner/zsh-autopair

zi ice as'command' pick'*'
zi light ~/src/github.com/m5d215/dotfiles/src/bin

zi ice as'completion'
zi snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

zi from'gh-r' as'command' blockf light-mode for \
    atload'eval "$(zabrze init --bind-keys)"' \
    Ryooooooga/zabrze

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

        local _path_aliases
        _path_aliases=$'~/src/=\ue702 SRC'
        _path_aliases+=$',~/src/github.com=\uf09b GITHUB'
        _path_aliases+=$',~/Library/Mobile Documents/com~apple~CloudDocs=\uf0c2 iCloud'
        _path_aliases+=$',~/Documents=\uf07b Documents'
        _path_aliases+=$',~/Downloads=\uf019 Downloads'

        eval "$(powerline-go \
            -cwd-mode semifancy \
            -duration "$__DURATION" \
            -error "$__ERRCODE" \
            -eval \
            -modules ssh,cwd,perms,jobs,exit \
            -modules-right duration,git \
            -numeric-exit-codes \
            -path-aliases "$_path_aliases" \
            -git-assume-unchanged-size 1024 \
            -shell zsh \
        )"
    }

    function install_powerline_precmd {
        local s
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

# key binding
function __discover_autoload {
    local _name

    while read -r _name
    do
        _name=${_name##*/}
        autoload -Uz "$_name"
        zle -N "$_name"
    done < <(find "$ZDOTDIR/functions/" -type f -print)
}

__discover_autoload
unset -f __discover_autoload

bindkey '^[^' cd-home
bindkey '^^' cd-up
bindkey '^y' copy-command
bindkey '^g^r' git-fuzzy-branch
bindkey '^g^g' git-fuzzy-log
bindkey '^g^w' git-fuzzy-work-tree
bindkey '^r' fuzzy-history
bindkey '^e^r' replace-command
bindkey '^e^l' ls-now
bindkey '^|' unpipe
bindkey '^e^i' toggle-history-ignore

# aliases
alias grep='grep --color=auto'
alias less='less --tabs=4'

if command -v eza >/dev/null 2>&1; then
    alias eza='eza --classify --color=always --icons --group-directories-first --group --header --git --time-style long-iso'
    alias ls=eza
fi

# mise
export PATH="$HOME/.local/share/mise/shims:$PATH"
