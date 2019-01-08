@if "%1" == "/I" (
    @mklink    "%HOME%\.aliases"       "%~dp0src\.aliases"
    @mklink    "%HOME%\.bash_profile"  "%~dp0src\.bash_profile"
    @mklink    "%HOME%\.bashrc"        "%~dp0src\.bashrc"
    @mklink    "%HOME%\.editorconfig2" "%~dp0src\.editorconfig"
    @mklink    "%HOME%\.environment"   "%~dp0src\.environment"
    @mklink    "%HOME%\.gitconfig"     "%~dp0src\.gitconfig"
    @mklink    "%HOME%\.minttyrc"      "%~dp0src\.minttyrc"
    @mklink    "%HOME%\.vimrc"         "%~dp0src\.vimrc"
) else if "%1" == "/U" (
    del "%HOME%\.aliases"
    del "%HOME%\.bash_profile"
    del "%HOME%\.bashrc"
    del "%HOME%\.editorconfig"
    del "%HOME%\.environment"
    del "%HOME%\.gitconfig"
    del "%HOME%\.minttyrc"
    del "%HOME%\.vimrc"
)
