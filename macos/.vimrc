set guifont=Menlo:h12
set encoding=utf8

if has("gui_running")
  colorscheme darkblue
endif

" Do not flash or beep
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" open netrw in new tabs and windows if no command line args
autocmd VimEnter * if !argc() | Vexplore | endif

" Enable use of the mouse for all modes
set mouse=a

 " Display line numbers on the left
set number

" Indentation settings for using 4 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=4
set softtabstop=4
set expandtab
set ts=4

" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype plugin indent on

" Show partial commands in the last line of the screen
set showcmd

" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible

" Better command-line completion
set wildmenu

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
"set autoindent

set backspace=indent,eol,start
set complete-=i
set smarttab
set nrformats-=octal
set viminfo='20,\"50
set history=1000

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

set si

" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch
syntax on

set laststatus=2

vmap r "_dP"

nmap <F1> :set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
imap <F1> <Esc>:set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
nmap <F2> :.w !pbcopy<CR><CR>
vmap <F2> :w !pbcopy<CR><CR>



let g:netrw_winsize = 25
let g:netrw_browse_split = 4
let g:netrw_liststyle = 3
let g:netrw_altv = 1



