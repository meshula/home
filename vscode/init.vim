
if exists('g:vscode')
    " running in VSCode
else
    " not in VSCode
endif

"set runtimepath+=~/.vim,~/.vim/after
"set packpath+=~/.vim
"source ~/.vimrc

let data_dir = has('nvim') ? stdpath('data') . '/site' : 'C:/bin/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  echom "installing plug.vim"
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins will be downloaded under the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" Declare the list of plugins.
Plug 'tpope/vim-sensible'
Plug 'junegunn/seoul256.vim'
Plug 'ziglang/zig.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'NLKNguyen/papercolor-theme'
Plug 'jacoborus/tender.vim'
Plug 'lukas-reineke/indent-blankline.nvim'
"Plug 'autozimu/LanguageClient-neovim', {
"    \ 'branch': 'next',
"    \ 'do': 'bash install.sh',
"    \ }

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

"let g:LanguageClient_serverCommands = {
"       \ 'zig': ['/Users/nporcino/bin/zls'],
"       \ }

"nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
"nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
"nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Enable completions as you type
let g:completion_enable_auto_popup = 1

" colorscheme papercolor
colorscheme tender

