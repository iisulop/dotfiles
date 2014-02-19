set nocompatible

" Required for Vundle
filetype off

" Vundle handles plugins
set rtp+=~/.vim/bundle/vundle
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'wincent/Command-T'
Bundle 'Valloric/YouCompleteMe'
Bundle 'tpope/vim-fugitive'

" Always 7 lines showing above and beyond the cursor
set scrolloff=7

" Tab behavior
set tabstop=2
set expandtab
set shiftwidth=2

set makeprg=ruby\ -w\ -c\ %

" Search behavior
set incsearch
set hlsearch
set ignorecase
set smartcase

" Show relative file path and git and line info in status bar
set statusline+=%f\ 
set statusline+=%{fugitive#statusline()}\ 
set statusline+=[line\ %l\/%L]
set laststatus=2

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Map leader to ',' for easier use
let mapleader = ","

" Syntax highlighting
filetype plugin indent on
syntax on

" Control-\ to open tag in new tab when following tags
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

" Relative numbers - absolute numbers
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc
nnoremap <C-n> :call NumberToggle()<cr>
set relativenumber
