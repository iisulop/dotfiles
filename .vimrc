set nocompatible

" Required for Vundle
filetype off

" Vundle handles plugins
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/vundle'
Plugin 'wincent/Command-T'
Plugin 'Valloric/YouCompleteMe'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-ragtag'
Plugin 'tpope/vim-surround'
Plugin 'bling/vim-airline'
Plugin 'ludovicchabant/vim-lawrencium'
Plugin 'brookhong/cscope.vim'
Plugin 'tfnico/vim-gradle'
Plugin 'davidhalter/jedi-vim'
"Plugin 'vim-syntastic/syntastic' "Conflicts with ale
Plugin 'hsanson/vim-android'
Plugin 'artur-shaik/vim-javacomplete2'
Plugin 'godlygeek/tabular'
Plugin 'plasticboy/vim-markdown'
Plugin 'rhysd/devdocs.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'sheerun/vim-polyglot'
Plugin 'w0rp/ale' " Requires json description for C/C++ compilation

call vundle#end()

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

nmap K <Plug>(devdocs-under-cursor)

" Syntax highlighting
filetype plugin indent on
syntax on

" Control-\ to open tag in new tab when following tags
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

" F5 to flush Command-T cache
nnoremap <F5> :call CommandTFlush()<cr>:call YcmForceCompileAndDiagnostics()<cr>

" F4 to move between header and source
nnoremap <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
nnoremap <F3> :e %:p:s,.h$,.X123X,:s,.c$,.h,:s,.X123X$,.c,<CR>

" Close buffer, keep split
nnoremap <leader>c :bp\|bd #<CR>

" Something for eclim
nnoremap <silent> <buffer> <leader>i :JavaImport<cr>
nnoremap <silent> <buffer> <leader>d :JavaDocSearch -x declaration<cr>
nnoremap <silent> <buffer> <cr> :JavaSearchContext<cr>

let g:EclimCompletionMethod = 'omnifunc'
let g:CommandTMatchWindowReverse = 1
let g:commandTMaxFiles = 300000


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

autocmd BufRead *.txt setlocal spell

"Find stray \302\204 (nbsp) by showing them as commas
set listchars+=nbsp:,


" Cscope things
" s: Find this C symbol
nnoremap  <leader>fs :call CscopeFind('s', expand('<cword>'))<CR>
" g: Find this definition
nnoremap  <leader>fg :call CscopeFind('g', expand('<cword>'))<CR>
" d: Find functions called by this function
nnoremap  <leader>fd :call CscopeFind('d', expand('<cword>'))<CR>
" c: Find functions calling this function
nnoremap  <leader>fc :call CscopeFind('c', expand('<cword>'))<CR>
" t: Find this text string
nnoremap  <leader>ft :call CscopeFind('t', expand('<cword>'))<CR>
" e: Find this egrep pattern
nnoremap  <leader>fe :call CscopeFind('e', expand('<cword>'))<CR>
" f: Find this file
nnoremap  <leader>ff :call CscopeFind('f', expand('<cword>'))<CR>
" i: Find files #including this file
nnoremap  <leader>fi :call CscopeFind('i', expand('<cword>'))<CR>

set colorcolumn=80
highlight ColorColumn ctermbg=NONE ctermfg=red guibg=NONE guifg=pink
autocmd FileType make setlocal shiftwidth=8 softtabstop=8 noexpandtab
autocmd FileType java setlocal shiftwidth=4 softtabstop=4 noexpandtab
autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab


" Just Java things
autocmd FileType java setlocal omnifunc=javacomplete#Complete
