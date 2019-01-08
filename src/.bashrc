[ -z "$PS1" ] && return

# powerline
if [ ! -z "${POWERLINE_HOME:-}" ] && [ -d "$POWERLINE_HOME" ]; then
    powerline-daemon --quiet
    . "$POWERLINE_HOME/bindings/bash/powerline.sh"
fi

# windows
if [ "$OSTYPE" == 'msys' ]; then
    export PS1='\[\e[36m\]WINDOWS \[\e[33m\]\w\[\e[36m\]`__git_ps1`\[\e[0m\] $ '
    [ "$(pwd)" == / ] && cd ~
fi

# completion
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

. ~/.aliases

# load user configuration
if [ -f ~/.config/shell/.usershell ]; then
    . ~/.config/shell/.usershell
fi
