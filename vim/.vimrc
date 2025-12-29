" vimrc
" ref. https://github.com/mhinz/vim-galore/blob/master/static/minimal-vimrc.vim

set nocompatible

syntax on                   " Enable syntax highlighting.
set autoindent              " Indent according to previous line.
set expandtab               " Use spaces instead of tabs.
set softtabstop =4          " Tab key indents by 4 spaces.
set shiftwidth  =4          " >> indents by 4 spaces.
set shiftround              " >> indents to next multiple of 'shiftwidth'.
set smartindent             " improve auto-indentation (including when pasting text)
set smarttab                " improve auto-identitation, space handling


set laststatus  =2          " Always show statusline.
"set display     =lastline   " Show as much as possible of the last line.
set showmode                " Show current mode in command-line.
set showcmd                 " Show already typed keys when more are expected.

set incsearch               " Highlight while searching with / or ?.
set hlsearch                " Keep matches highlighted.

set cursorline              " Find the current line quickly.
set list                    " Show non-printable characters.
set number                  " Show line number
set termguicolors           " Set vim colors

filetype on             " Detect file type
set linebreak               " Cut at the last word and not the last character (requires wrap line enabled)
set visualbell              " Blink instead of beep
set showmatch               " Highlight the keyword searched
set hlsearch                " Highlight all search results



