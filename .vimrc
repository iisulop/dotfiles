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
Bundle 'tpope/vim-unimpaired'
Bundle 'tpope/vim-ragtag'
Bundle 'bling/vim-airline'
Bundle 'ludovicchabant/vim-lawrencium'

" Set mouse support on
set mouse=a

" Always 7 lines showing above and beyond the cursor
set scrolloff=7


" Tab behavior
set expandtab
set tabstop=2
set shiftwidth=2

" Recognise underscore as word break
"set iskeyword-=_

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

if has('autocmd')
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

set background=dark
if has('gui_running')
  "set background=light
  colorscheme solarized
  set guifont=Droid\ Sans\ Mono\ for\ Powerline\ 9
endif

" Map leader to ',' for easier use
let mapleader = ","

" map j to gj and k to gk, so line navigation ignores line wrap
nmap j gj
nmap k gk

" Syntax highlighting
filetype plugin indent on
syntax on

" Control-\ to open tag in new tab when following tags
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

" F5 to flush Command-T cache
nnoremap <F5> :call CommandTFlush()<cr>:call YcmForceCompileAndDiagnostics()<cr>

" F4 to move between header and source
nnoremap <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

" Close buffer, keep split
nnoremap <leader>c :bp\|bd #<CR>

" Something for eclim
nnoremap <silent> <buffer> <leader>i :JavaImport<cr>
nnoremap <silent> <buffer> <leader>d :JavaDocSearch -x declaration<cr>
nnoremap <silent> <buffer> <cr> :JavaSearchContext<cr>

let g:EclimCompletionMethod = 'omnifunc'
let g:CommandTMatchWindowReverse = 1


let g:ycm_extra_conf_globlist = ['/home/iiro/dev/*']

function! GnuIndent()
  setlocal cinoptions=>4,n-2,{2,^-2,:2,=2,g0,h2,p5,t0,+2,(0,u0,w1,m1
  setlocal shiftwidth=2
  setlocal softtabstop=2
  setlocal fo-=ro fo+=cql
endfunc
au FileType c,cpp call GnuIndent()

set relativenumber
set number

let g:airline#extensions#tabline#enabled=1
let g:airline_powerline_fonts = 1


"Highlight whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

autocmd FileType make setlocal shiftwidth=8 softtabstop=8 noexpandtab

set colorcolumn=80
highlight ColorColumn ctermbg=NONE ctermfg=red guibg=NONE guifg=pink
