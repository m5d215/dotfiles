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

function zshaddhistory()
{
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

    function preexec() {
        __TIMER=$EPOCHREALTIME
    }

    function powerline_precmd() {
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

    function install_powerline_precmd() {
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

# abbrev-alias
abbrev-alias -g G='| grep --color=yes -Hn'
abbrev-alias -g L='| less'

abbrev-alias -g X='| xargs'
abbrev-alias -g X0='| xargs -0'
abbrev-alias -g XG='| xargs grep --color=yes -Hn'
abbrev-alias -g X0G='| xargs -0 grep --color=yes -Hn'

abbrev-alias -g FF='find . -type f -name'
abbrev-alias -g FD='find . -type d -name'
abbrev-alias -g FG='find . -type d -name .git -prune -o -print'
abbrev-alias -g FGN='find . -type d \( -name .git -o -name node_modules \) -prune -o -print'

abbrev-alias -g F='| fzf'
abbrev-alias -g FP="| fzf --preview='bat --color=always --style=numbers {}' --preview-window=down"

abbrev-alias -g J='| jq .'

if [[ "$OSTYPE" =~ ^darwin ]]; then
    abbrev-alias -g C='| pbcopy'
    abbrev-alias -g CC='| tee >(pbcopy)'
    abbrev-alias -g P='pbpaste'
fi

# key binding
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
