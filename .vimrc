vim9script

set nocompatible              # be iMproved, required
filetype off                  # required

# set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim

vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'ap/vim-css-color'
Plugin 'felixhummel/setcolors.vim'
Plugin 'fatih/vim-go'
Plugin 'flazz/vim-colorschemes'
Plugin 'jiangmiao/auto-pairs'
Plugin 'junegunn/fzf', { 'do': './install --bin' }
Plugin 'junegunn/fzf.vim'
Plugin 'mileszs/ack.vim'
Plugin 'mxw/vim-jsx'
Plugin 'pangloss/vim-javascript'
Plugin 'posva/vim-vue'
Plugin 'tpope/vim-unimpaired'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'vim-syntastic/syntastic'
Plugin 'wavded/vim-stylus'
Plugin 'rust-lang/rust.vim'
Plugin 'mustache/vim-mustache-handlebars'
vundle#end()

filetype plugin indent on

if v:progname =~? "evim"
  finish
endif

# Get the defaults that most users want.
if !has('nvim')
  source $VIMRUNTIME/defaults.vim
endif

if has("vms")
  set nobackup		# do not keep a backup file, use versions instead
else
  set backup		# keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	# keep an undo file (undo changes after closing)
  endif
endif

# Open Quickfix
nnoremap <C-c> :copen<CR>

# Setup ack to use rg for searching
g:ackprg = 'rg --color=never --no-heading --with-filename --line-number --column'
g:ack_autoclose = 1
cnoreabbrev ag Ack!
cnoreabbrev aG Ack!
cnoreabbrev Ag Ack!
cnoreabbrev AG Ack!

# Map CTRL-P To FZF
nnoremap <C-p> :Files<CR>
$FZF_DEFAULT_COMMAND = 'rg --hidden --files'

# New splits go right
set splitright

# Tabs to Spaces (4 lyfe)
set tabstop=2 shiftwidth=2 expandtab

# Keep buffers open in background
set hidden

# Show trailing space after line
set list lcs=trail:·,tab:»·

set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.idea/*,*/.DS_Store,*/vendor,*/node_modules/*,*/public/js/_*

# OmniComplete
set completeopt=longest,menuone
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <C-n> pumvisible() ? '<C-n>' : '<C-n><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'
inoremap <expr> <M-,> pumvisible() ? '<C-n>' : '<C-x><C-o><C-n><C-p><C-r>=pumvisible() ? "\<lt>Down>" : ""<CR>'

# ColorScheme
syntax enable
colorscheme tender
set termguicolors

# Transparent Background
hi Normal guibg=NONE ctermbg=NONE

# Backup file location
set backupdir=~/.tmp

# No Undo Files
set noundofile

# Fuzzy File Search
set rtp+=~/.fzf

set encoding=utf-8

# Airline config
g:airline#extensions#tabline#enabled = 1
g:airline_powerline_fonts = 1
g:airline_theme = 'minimalist'

# Only show filename for buffers
g:airline#extensions#tabline#fnamemod = ':t'

# Hybrid line numbers
set number relativenumber
set nu rnu

# Syntastic config for linting
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
g:syntastic_always_populate_loc_list = 0
g:syntastic_auto_loc_list = 1
g:syntastic_check_on_open = 0
g:syntastic_check_on_wq = 0
g:syntastic_mode_map = { "mode": "active" }
g:syntastic_javascript_checkers = ['eslint']
g:syntastic_typescript_checkers = ['eslint']

# Rust
g:rustfmt_autosave = 1
