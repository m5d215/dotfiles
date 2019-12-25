[ -z "$PS1" ] && return

# windows
if [ "$OSTYPE" == 'msys' ]; then
    # prompt
    export PS1='\[\e[36m\]WINDOWS \[\e[33m\]\w\[\e[36m\]`__git_ps1`\[\e[0m\] $ '
    [ "$(pwd)" == / ] && cd ~

    # colorscheme
    if [ ! -d ~/src/github.com/sonatard/terminal-color-theme ]; then
        git clone --recurse-submodules https://github.com/sonatard/terminal-color-theme ~/src/github.com/sonatard/terminal-color-theme
    fi
    source ~/src/github.com/sonatard/terminal-color-theme/color-theme-molokai/molokai.sh

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
