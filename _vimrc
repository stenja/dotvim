set nocompatible
set backspace=indent,eol,start
set history=100
set ruler
set showcmd
set incsearch
set guioptions=r
set nobackup
set nowritebackup
set hidden
set ignorecase
set smartcase
set number
set guifont=DejaVu\ Sans\ Mono\ 9,Consolas:h9:cANSI
set scrolloff=2
if !isdirectory($HOME."/vim_swap")
	call mkdir($HOME."/vim_swap", "p")
endif
set directory=$HOME/vim_swap//
let mapleader=","
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif
if has("autocmd")
  filetype plugin indent on
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
else
  set autoindent
endif
call pathogen#infect()
color jellybeans

map <MiddleMouse> <Nop>
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-l> :wincmd l<CR>
nmap <silent> <C-Left> :vertical resize -1<CR>
nmap <silent> <C-Right> :vertical resize +1<CR>
nmap <silent> <C-Up> :resize -1<CR>
nmap <silent> <C-Down> :resize +1<CR>
nmap <silent> <C-Tab> :bn<CR>
nmap <silent> <C-S-Tab> :bp<CR>
imap <C-BS> <C-W>
inoremap ii <Esc>
vnoremap ii <Esc>
nmap <silent> <leader>h :noh<CR>
nmap <silent> <leader>s :FSHere<CR>
nmap <silent> <leader>n :NERDTreeToggle<CR>
nmap <silent> <leader>m :NERDTreeCWD<CR>
nmap <silent> <leader>w :Bclose<CR>
nmap <silent> <leader>q :Bclose!<CR>
nmap <silent> <leader>u :GundoToggle<CR>
nmap <silent> <leader>g <Plug>(easymotion-bd-w)
nmap <silent> <leader>a "+
vmap <silent> <leader>a "+
nmap <leader>r :set relativenumber! relativenumber?<CR>
nmap <leader>l :set wrap! wrap?<CR>
nmap <silent> ]q :cnext<CR>
nmap <silent> [q :cprevious<CR>
nmap <silent> ]t :bn<CR>
nmap <silent> [t :bp<CR>
let c=1
while c < 100 
	execute "nmap <silent> <leader>" . c . " :b" . c . "<CR>"
	let c += 1
endwhile
let g:EasyMotion_off_screen_search=0
let g:EasyMotion_do_shade=0
let NERDTreeMouseMode=2
let g:gundo_prefer_python3=1
let g:gundo_right=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#fnamemod=':t'
let g:airline#extensions#tabline#buffer_nr_show=1
let g:EasyGrepRecursive=1
let g:EasyGrepWindow=1
set completeopt=longest,menuone,preview
set mouse=
