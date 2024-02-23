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

" disable before loading vim-polyglot
let g:polyglot_disabled = ['markdown']

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
Plug 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
Plug 'junegunn/fzf.vim'
Plug 'godlygeek/tabular'
Plug 'preservim/vim-markdown'
Plug 'sheerun/vim-polyglot'
Plug 'dense-analysis/ale'
Plug 'Yggdroot/indentLine'
Plug 'machakann/vim-highlightedyank'
call plug#end()


" -----------------------------------------------------------------------------
" COLORSCHEME & APPEARANCE
" -----------------------------------------------------------------------------

" set these before calling colorscheme
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_sign_column='NONE'
let g:lightline = { 'colorscheme': 'gruvbox' }

syntax on
filetype plugin indent on

set background=dark
colorscheme gruvbox

" check if term supports 24-bit color
if (has("termguicolors"))
  " https://github.com/vim/vim/issues/993#issuecomment-255651605
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

  set termguicolors

  " sets transparent background
  " must come after colorscheme
  hi Normal guibg=NONE ctermbg=NONE
  " sets transparent signcolumn background
  " see also set gruvbox_sign_column above
  hi SignColumn guibg=NONE ctermbg=NONE
  " vsplit column transparent background
  hi VertSplit guibg=NONE cterm=NONE
endif

" Specific colorscheme settings (must come after setting your colorscheme).
if (g:colors_name == 'gruvbox')
  if (&background == 'dark')
    " hi Visual cterm=NONE ctermfg=NONE ctermbg=237 guibg=#3a3a3a
  else
    hi Visual cterm=NONE ctermfg=NONE ctermbg=228 guibg=#f2e5bc
    hi CursorLine cterm=NONE ctermfg=NONE ctermbg=228 guibg=#f2e5bc
    hi ColorColumn cterm=NONE ctermfg=NONE ctermbg=228 guibg=#f2e5bc
  endif
endif

" set comments to italic
hi Comment cterm=italic gui=italic

" Use a line cursor within insert mode and a block cursor everywhere else.
"
" Reference chart of values:
"   Ps = 0  -> blinking block.
"   Ps = 1  -> blinking block (default).
"   Ps = 2  -> steady block.
"   Ps = 3  -> blinking underline.
"   Ps = 4  -> steady underline.
"   Ps = 5  -> blinking bar (xterm).
"   Ps = 6  -> steady bar (xterm).
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" make the vsplit border nicer
set fillchars+=vert:\▏

" set the highlighted yank duration
let g:highlightedyank_highlight_duration = 200

if !exists('##TextYankPost')
  nmap y <Plug>(highlightedyank)
  xmap y <Plug>(highlightedyank)
  omap y <Plug>(highlightedyank)
endif


" -----------------------------------------------------------------------------
" OPTIONS
" -----------------------------------------------------------------------------

let mapleader=" "
let maplocalleader=" "

let netrw_banner=0
let netrw_browse_split=0
let netrw_winsize=25
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',.git'

set encoding=utf-8
scriptencoding utf-8
set nocompatible

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

if has("wildmenu")
  set wildignore+=*.a,*.o,*.obj,*.pyc,*~
  set wildmode=list:longest,full
  set wildmenu
  set wildignorecase
endif

set updatetime=50
set timeoutlen=400
set cmdheight=1
set colorcolumn=80
set signcolumn=yes
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

" better default experience
nnoremap <silent> <space> <nop>
vnoremap <silent> <space> <nop>
nnoremap <silent> Q <nop>

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
nnoremap <silent> <leader><TAB> <C-w>w

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

" buffer nav & close
nnoremap <silent> <TAB> :bnext<CR>
nnoremap <silent> <S-TAB> :bprevious<CR>
nnoremap <silent> <S-l> :bnext<CR>
nnoremap <silent> <S-h> :bprevious<CR>
nnoremap <silent> <leader>bd :bd<CR>

" pretty print json
nnoremap <silent> <leader>pj <cmd>%!jq '.'<CR>

" compress json
nnoremap <silent> <leader>pjj <cmd>%!jq -r tostring<CR>

" Save file as sudo on files that require root permission
cabbrev w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Toggle spell check.
nnoremap <F5> :setlocal spell!<CR>
inoremap <F5> <C-o>:setlocal spell!<CR>

" Toggle relative line numbers and regular line numbers.
nnoremap <F6> :set relativenumber!<CR>
inoremap <F6> <C-o>:set relativenumber!<CR>


" -----------------------------------------------------------------------------
" AUTOCOMMANDS
" -----------------------------------------------------------------------------

if has('autocmd')

  " disable automatic commenting on newline
  autocmd FileType * setlocal formatoptions-=cro

endif


" -----------------------------------------------------------------------------
" PLUGIN SETTINGS (vim-markdown)
" -----------------------------------------------------------------------------

" Disable folding.
let g:vim_markdown_folding_disabled = 1

" Fold heading in with the contents.
let g:vim_markdown_folding_style_pythonic = 1

" Don't use the shipped key bindings.
let g:vim_markdown_no_default_key_mappings = 1

" Autoshrink TOCs.
let g:vim_markdown_toc_autofit = 1

" Indentation for new lists. We don't insert bullets as it doesn't play
" nicely with `gq` formatting. It relies on a hack of treating bullets
" as comment characters.
" See https://github.com/plasticboy/vim-markdown/issues/232
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_auto_insert_bullets = 0

" Filetype names and aliases for fenced code blocks.
let g:vim_markdown_fenced_languages = ['py=python', 'js=javascript', 'bash=sh', 'yml=yaml']

" Highlight front matter (useful for Hugo posts).
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_frontmatter = 1

" Format strike-through text (wrapped in `~~`).
let g:vim_markdown_strikethrough = 1

" Use `ge` to follow named anchors in links
let g:vim_markdown_follow_anchor = 1

" autosave before following links with `ge`
let g:vim_markdown_autowrite = 1

" disable conceal regardless of conceallevel
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0


" -----------------------------------------------------------------------------
" PLUGIN SETTINGS (fzf)
" -----------------------------------------------------------------------------

let g:fzf_colors = {
\ 'fg':      ['fg', 'Normal'],
\ 'bg':      ['bg', 'Normal'],
\ 'hl':      ['fg', 'Comment'],
\ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
\ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
\ 'hl+':     ['fg', 'Statement'],
\ 'info':    ['fg', 'PreProc'],
\ 'border':  ['fg', 'Ignore'],
\ 'prompt':  ['fg', 'Conditional'],
\ 'pointer': ['fg', 'Exception'],
\ 'marker':  ['fg', 'Keyword'],
\ 'spinner': ['fg', 'Label'],
\ 'header':  ['fg', 'Comment'] }

" Launch fzf with CTRL+P.
nnoremap <silent> <C-p> :GFiles -m<CR>

" Map a few common things to do with FZF.
nnoremap <silent> <Leader><Enter> :Buffers<CR>
nnoremap <silent> <Leader>l :Lines<CR>
