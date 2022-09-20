let mapleader = ","

nmap j gj
nmap k gk

set lbr
set number relativenumber
set scrolloff=7
set incsearch
set hlsearch
set ignorecase
set smartcase
set nofoldenable

set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " number of spaces to use for autoindent
set expandtab       " tabs are space
set autoindent
set copyindent      " copy indent from the previous line

autocmd BufNewFile,BufRead *.elm set shiftwidth=4 | set tabstop=4
autocmd BufNewFile,BufRead *.hs set shiftwidth=2 | set tabstop=2
autocmd BufNewFile,BufRead *.json set shiftwidth=2 | set tabstop=2
autocmd BufNewFile,BufRead *.md set shiftwidth=2 | set tabstop=2
autocmd BufNewFile,BufRead *.purs set shiftwidth=4 | set tabstop=4
autocmd BufNewFile,BufRead *.yml set shiftwidth=2 | set tabstop=2
autocmd BufNewFile,BufRead Makefile set noexpandtab
autocmd BufNewFile,BufRead *.lua set shiftwidth=2 | set tabstop=2
autocmd BufRead Cargo.toml call crates#toggle()

syntax on
colorscheme nord
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }

filetype plugin on

lua require('plugins')
lua require('pluginit')
lua require('opts')
lua require('completion')
lua require('lsp')
lua require('keys')

nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
