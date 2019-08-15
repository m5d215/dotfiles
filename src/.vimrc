set background=dark
colorscheme hybrid_material

" Enable syntax highlighting
syntax on

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" Highlight current line
set cursorline

" Set default encoding to UTF-8
set encoding=utf-8
set fileencodings=utf-8

" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch

" Always display the status line, even if only one window is displayed
set laststatus=2

" Display special chars
set list
set listchars=tab:>-,extends:<,trail:-

" Don't change title
set notitle

" Display line numbers on the left
set number

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Show partial commands in the last line of the screen
set showcmd

" Better commandline completion
set wildmenu

" Don't create .viminfo
set viminfo=

" Indentation settings for using 4 spaces instead of tabs.
set smartindent
set shiftwidth=4
set tabstop=4
set softtabstop=4
set expandtab

" Powerline
let g:airline_powerline_fonts = 1

if system('uname') =~ 'MINGW'
else
    call plug#begin('~/.vim/plugged')

    Plug 'kristijanhusak/vim-hybrid-material', {'do': 'cp -a colors ~/.vim/'}
    Plug 'vim-airline/vim-airline'

    call plug#end()
endif

" Key bindings
inoremap <silent> jj <ESC>
