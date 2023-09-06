"
"      ██╗   ██╗██╗███╗   ███╗██████╗  ██████╗
"      ██║   ██║██║████╗ ████║██╔══██╗██╔════╝
"      ██║   ██║██║██╔████╔██║██████╔╝██║
"      ╚██╗ ██╔╝██║██║╚██╔╝██║██╔══██╗██║
"       ╚████╔╝ ██║██║ ╚═╝ ██║██║  ██║╚██████╗
"        ╚═══╝  ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝
"

" -----------------------------------------------------------------------------
" PLUGINS
" -----------------------------------------------------------------------------

" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -sSfLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin()
Plug 'gruvbox-community/gruvbox'
Plug 'itchyny/lightline.vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'
Plug 'Yggdroot/indentLine'
call plug#end()


" -----------------------------------------------------------------------------
" OPTIONS
" -----------------------------------------------------------------------------

let mapleader = ' '

let netrw_banner=0
let netrw_browse_split=0
let netrw_winsize=25
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',.git'

set encoding=utf-8
scriptencoding utf-8
set nocompatible
set background=dark

let g:gruvbox_contrast_dark='hard'
colorscheme gruvbox
syntax on
filetype plugin indent on

let g:lightline = { 'colorscheme': 'gruvbox' }
set laststatus=2
set noshowmode

set belloff=all
set number
set relativenumber
set title
set mouse=a

set breakindent
set linebreak
set nowrap

set autoindent
set expandtab
set shiftwidth=2
set smartindent
set smarttab
set softtabstop=2
set tabstop=2

set hlsearch
set ignorecase
set incsearch
set smartcase

set tabpagemax=50
set ruler
set numberwidth=4
set showmatch
set autoread
set cursorline
set backspace=indent,eol,start

set wildmenu
set wildmode=list:longest,full
set wildignore=*.o,*.obj,*.pyc,*~

set updatetime=50
set timeoutlen=400
set cmdheight=1
set colorcolumn=80
set signcolumn="yes"
set scrolloff=8
set sidescrolloff=20
set sidescroll=1

" create undodir path
if !isdirectory($HOME."/.cache/vim/undo")
    call mkdir($HOME."/.cache/vim/undo", 'p', 0700)
endif

" if supported set location and enable
if has('persistent_undo')
  set undodir=$XDG_CACHE_HOME/vim/undo
  set undofile
endif

set undolevels=1000
set nobackup nowritebackup
set noswapfile


" -----------------------------------------------------------------------------
" MAPPINGS
" -----------------------------------------------------------------------------

" open netrw
nnoremap <leader>pv :Ex<CR>

" deal with line wrap
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" move lines up and down
vnoremap J :move '>+1<CR>gv=gv
vnoremap K :move '<-2<CR>gv=gv

" keep centered
nnoremap J mzJ`z
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
nnoremap n nzzzv
nnoremap N Nzzzv

" tab indent
xnoremap <Tab> >gv
xnoremap <S-Tab> <gv

" move between splits
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>
nnoremap <C-L> <C-w><C-L>
nnoremap <C-H> <C-w><C-H>

" paste over selected text without yanking it
xnoremap <leader>p "_dP

" yank to clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y

" yank line to clipboard
nnoremap <leader>Y "+Y

" yank to end of line
nnoremap Y y$

"delete current line adding it to the default register
nnoremap <leader>d "_d
vnoremap <leader>d "_d

"replace all occurrences of the word under cursor
nnoremap <leader>s :%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>

" clear search highlight on enter
nnoremap <silent> <CR> :nohlsearch<CR>

" toggle search highlight
noremap <silent> <leader>h :set hlsearch! hlsearch?<CR>

" make the current file executable
nnoremap <silent> <leader>x <cmd>!chmod +x %<CR>

" toggle Goyo
nnoremap <leader>g :Goyo<CR>

" Save file as sudo on files that require root permission
cabbrev w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!


" -----------------------------------------------------------------------------
" FUNCTIONS
" -----------------------------------------------------------------------------

function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

" https://github.com/junegunn/goyo.vim/issues/36
function! s:auto_goyo()
  if &ft == 'markdown'
    Goyo 80
  elseif exists('#goyo')
    let bufnr = bufnr('%')
    Goyo!
    execute 'b '.bufnr
  endif
endfunction

if has('autocmd')

  " disable automatic commenting on newline
  autocmd FileType * setlocal formatoptions-=cro

  " Set Limelight to activate/deactivate when Goyo opens/closes
  autocmd! User GoyoEnter Limelight
  autocmd! User GoyoLeave Limelight!

  augroup goyo_markdown
      autocmd!
      autocmd BufNewFile,BufRead * call s:auto_goyo()
  augroup END

endif
