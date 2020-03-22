" Cd automatically when opening files
set autochdir

" Leader mappings
let mapleader = "\<Space>"
let g:mapleader = "\<Space>"

" Save
nmap <leader>w :w!<cr>

" Quit
nmap <leader>q :q<cr>
nmap <leader>Q :qa<cr>

" Search
nmap <leader><leader> /

" Splits
nmap <leader>v :vsplit<cr>
nmap <leader>h :split<cr>

" Go leader shortcuts
nmap <leader>gd :GoDef<cr>
nmap <leader>gp :GoDefPop<cr>
nmap <leader>gm :GoMetaLinter<cr>
nmap <leader>gr :GoRename<cr>

" Sets how many lines of history VIM has to remember
set history=10000

" Share system clipboard
set clipboard=unnamedplus

" Enable filetype plugins
filetype plugin on
filetype indent on

" Set to auto read when a file is changed from the outside
set autoread

" Turn on the WiLd menu
set wildmenu

" A buffer becomes hidden when it is abandoned
set hid

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Makes search act like search in modern browsers
set incsearch

" Show matching brackets when text indicator is over them
set showmatch 
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500

" Enable syntax highlighting
syntax enable

" Highlight column
set colorcolumn=100

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs ;)
set smarttab

" Tab width
set shiftwidth=2
set tabstop=2

" Linebreak on 500 characters
set lbr
set tw=500

" Auto indent
set ai 
" Smart indent
set si
" Wrap lines
set wrap

" Smart way to move between windows
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-h> <C-W>h
nnoremap <C-l> <C-W>l

" Remap VIM 0 to first non-blank character
map 0 ^

" Better mouse interaction
set mouse=a

" Always show status line
set laststatus=2

" Line numbers
set cursorline
"set relativenumber
set number

" Disable ruler
set noruler

" Break vi compat
set nocompatible

" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile

" Persistent Undo 
" Make sure a tmp folder exists
silent !mkdir -p ~/.local/vim/tmp > /dev/null 2>&1

set undofile
set undodir=~/.local/vim/tmp
set undolevels=10000

" No esc delay
set timeoutlen=1000 ttimeoutlen=0

" Hide default vim mode shower
set noshowmode

""" Plugins
if empty(glob('~/.config/nvim/plug.vim'))
  silent !curl -fLo ~/.config/nvim/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin()

" Features
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'

" Languages
Plug 'fatih/vim-go'

" Theme
Plug 'joshdick/onedark.vim'

call plug#end()

""" Plugin configuration

" Go
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_fmt_command = "goimports"
set completeopt-=preview

" Fuzzy finders
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
map <C-b> :CtrlPBuffer<cr>

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

"" Theme
" Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
" If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
" (see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
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

colorscheme onedark
