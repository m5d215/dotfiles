# history
HISTFILE=$ZDOTDIR/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt extended_history
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_no_store
setopt hist_reduce_blanks
setopt share_history

function zshaddhistory()
{
    (( $#1 > 3 ))
}

# powerline
if [ ! -z "${POWERLINE_HOME:-}" ] && [ -d "$POWERLINE_HOME" ]; then
    powerline-daemon --quiet
    . "$POWERLINE_HOME/bindings/zsh/powerline.zsh"
fi

# zplug
. "$ZPLUG_HOME/init.zsh"

zplug b4b4r07/enhancd, use:init.sh
zplug hlissner/zsh-autopair, defer:2
zplug junegunn/fzf-bin, as:command, from:gh-r, rename-to:fzf
zplug junegunn/fzf, as:command, use:bin/fzf-tmux
zplug momo-lab/zsh-abbrev-alias
zplug zsh-users/zsh-autosuggestions
zplug zsh-users/zsh-completions
zplug zsh-users/zsh-syntax-highlighting

zplug check --verbose || zplug install
zplug load

. ~/.aliases

# abbrev-alias
abbrev-alias -g G='| grep --color=yes -n'
abbrev-alias -g L='| less'

abbrev-alias -g X='| xargs'
abbrev-alias -g X0='| xargs -0'
abbrev-alias -g XG='| xargs grep --color=yes -n'
abbrev-alias -g X0G='| xargs -0 grep --color=yes -n'

abbrev-alias -g FF='find . -type f -name'
abbrev-alias -g FD='find . -type d -name'
abbrev-alias -g FG='find . -type d -name .git -prune -o -print'
abbrev-alias -g FGN='find . -type d \( -name .git -o -name node_modules \) -prune -o -print'

abbrev-alias -g HJ="-H 'Content-Type: application/json'"
abbrev-alias -g HL='127.0.0.1'

abbrev-alias -g _POST="-X POST -H 'Content-Type: application/json' -d"
abbrev-alias -g _PUT="-X PUT -H 'Content-Type: application/json' -d"
abbrev-alias -g _DELETE="-X DELETE"

abbrev-alias -g F='| fzf'
abbrev-alias -g FI='"$(find . -type d \( -name .git -o -name node_modules \) -prune -o -print | tail -n +2 | cut -c 3- | fzf)"'

# key binding
autoload -Uz cd-up
autoload -Uz docker-fuzzy-container
autoload -Uz docker-fuzzy-image
autoload -Uz explore
autoload -Uz git-fuzzy-branch
autoload -Uz git-fuzzy-log
autoload -Uz git-fuzzy-work-tree
autoload -Uz fuzzy-history
autoload -Uz fuzzy-npm
zle -N cd-up
zle -N docker-fuzzy-container
zle -N docker-fuzzy-image
zle -N explore
zle -N explore-source
zle -N git-fuzzy-branch
zle -N git-fuzzy-log
zle -N git-fuzzy-work-tree
zle -N fuzzy-history
zle -N fuzzy-npm
bindkey '^^' cd-up
bindkey '^e^v' docker-fuzzy-container
bindkey '^e^i' docker-fuzzy-image
bindkey '^e^e' explore
bindkey '^e^g' explore-source
bindkey '^g^r' git-fuzzy-branch
bindkey '^g^g' git-fuzzy-log
bindkey '^g^w' git-fuzzy-work-tree
bindkey '^g^n' fuzzy-npm
bindkey '^r' fuzzy-history

# load user configuration
if [ -f ~/.config/shell/.usershell ]; then
    . ~/.config/shell/.usershell
fi
