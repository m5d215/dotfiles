[ -z "$PS1" ] && return

# powerline
if [ ! -z "${POWERLINE_HOME:-}" ] && [ -d "$POWERLINE_HOME" ]; then
    powerline-daemon --quiet
    . "$POWERLINE_HOME/bindings/bash/powerline.sh"
fi

# windows
if [ "$OSTYPE" == 'msys' ]; then
    # prompt
    export PS1='\[\e[36m\]WINDOWS \[\e[33m\]\w\[\e[36m\]`__git_ps1`\[\e[0m\] $ '
    [ "$(pwd)" == / ] && cd ~

    # colorscheme
    if [ ! -d ~/.ghq/github.com/sonatard/terminal-color-theme ]; then
        git clone --recurse-submodules https://github.com/sonatard/terminal-color-theme ~/.ghq/github.com/sonatard/terminal-color-theme
    fi
    source ~/.ghq/github.com/sonatard/terminal-color-theme/color-theme-molokai/molokai.sh

    # immersive
    if [ ! -f ~/.ghq/github.com/manabedaiki/immersive/immersive.exe ]; then
        mkdir -p ~/.ghq/github.com/manabedaiki/immersive
        curl -fsSL https://github.com/manabedaiki/immersive/releases/download/release%2F1.0/immersive.exe -o ~/.ghq/github.com/manabedaiki/immersive/immersive.exe
    fi

    function _exec_immersive()
    {
        local _uid _pid _ppid _tty _stime _command
        while read -r _uid _pid _ppid _tty _stime _command
        do
            if [ "$_pid" != "$PPID" ]; then
                return
            fi
        done < <(ps -f | tail -n +2 | grep '/usr/bin/mintty')
        ~/.ghq/github.com/manabedaiki/immersive/immersive.exe --pid "$PPID"
    }

    _exec_immersive
    unset _exec_immersive

    # PATH
    if [ -d "/C/Program Files (x86)/Microsoft Visual Studio/2017/Community/MSBuild/15.0/Bin" ]; then
        export PATH="/C/Program Files (x86)/Microsoft Visual Studio/2017/Community/MSBuild/15.0/Bin:$PATH"
    fi

    if [ -d "/C/Program Files (x86)/GnuWin32/bin" ]; then
        export PATH="/C/Program Files (x86)/GnuWin32/bin:$PATH"
    fi
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
