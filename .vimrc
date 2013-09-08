" This must be first, because it changes other options as a side effect.
set nocompatible               " be iMproved

""" START VUNDLE CONF """
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

Bundle 'altercation/vim-colors-solarized'
Bundle 'terhechte/syntastic'
Bundle 'eraserhd/vim-ios.git'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-surround'
Bundle 'kien/ctrlp.vim'
Bundle 'cocoa.vim'
Bundle 'clang-complete'
Bundle 'tomasr/molokai'
Bundle 'guns/ultisnips'
Bundle "b4winckler/vim-objc"
Bundle "bling/vim-airline"

filetype plugin indent on     " required!
""" END VUNDLE CONF """

syntax enable
colorscheme molokai 
set t_Co=256
let g:airline_theme='wombat'

set ignorecase          " case insenstive search
set nobackup            " no annoying ~ files
set hlsearch            " highlight search results
set autochdir           " auto switch to file's working directory
set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands
set ts=4                " tab stop
set incsearch           " do incremental searching
set autoindent          " always set autoindenting on
set cursorline          " for crosshair (doesn't play well with clang complete)
set cursorcolumn        " for crosshair 
set formatoptions=l     " don't autoformat long lines
set lbr                 " wrap long lines at a space
set scrolloff=10        " stay 10 lines from edge when scrolling
set bs=indent,eol,start " backspace over everything in insert mode
set number              " line numbers on
set laststatus=2 	    " Always show status line
set timeoutlen=1000     " timeout for user escape sequences
set ttimeoutlen=10		" timeout for system escape sequences

"switch between .mm/m  and .h
map <C-Tab> :A<cr>

"syntax highlight .template as .xml
au BufNewFile,BufRead *.template set filetype=xml

" change search/replace case sensitivity with f2
nmap <F2> :set ignorecase! ignorecase? <CR>
" wrapping shortcut
nmap <F3> :set wrap! wrap? <CR>

" Cursor crosshair, switch with \c
hi CursorLine   cterm=NONE ctermbg=232
hi CursorColumn cterm=NONE ctermbg=232
nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>

" Adds a #include (or #import) directive
" :Import Something.h
func! Include(name, directive)
  let l:stmt = a:directive . " \"" . a:name . "\""
  normal! mh
  try
    execute "?^#[       ]*\\(import\\|include\\)"
    execute "normal! o" . l:stmt
  catch
    execute "normal! ggi" . l:stmt . "\<CR>"
  endtry
  normal! `h
endfunc
com! -nargs=1 -complete=file Import :call Include(<q-args>,"#import")
com! -nargs=1 -complete=file Include :call Include(<q-args>,"#include")

" CLANG COMPLETE
" Complete options (disable preview scratch window)
set completeopt=menu,menuone,longest
" Show clang errors in the quickfix window
let g:clang_complete_copen=1
" For Objective-C, this needs to be active, otherwise multi-parameter methods
" won't be completed correctly
let g:clang_snippets=1
let g:clang_snippets_engine='ultisnips'
let g:clang_exec='/usr/bin/clang'
let g:clang_library_path='/usr/lib/libclang.dylib'

" SYNTASTIC
" Show sidebar signs.
let g:syntastic_enable_signs=1
" Read the clang complete file
let g:syntastic_objc_config_file='.clang_complete'
nnoremap <silent> ` :Errors<CR>
" Tell it to use clang instead of gcc
let g:syntastic_objc_checker='clang'
