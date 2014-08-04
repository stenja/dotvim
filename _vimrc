set nocompatible
set backspace=indent,eol,start
set history=100
set ruler
set showcmd
set incsearch
if has('mouse')
  set mouse=a
endif
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

set guioptions=
set nobackup
set nowritebackup
set hidden
set directory=$HOME//
let mapleader = ","
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
inoremap ii <Esc>
vnoremap ii <Esc>
nmap <silent> <leader>h :noh<CR>
nmap <silent> <leader>s :FSHere<CR>
nmap <silent> <leader>n :NERDTreeToggle<CR>
nmap <silent> <leader>m :NERDTreeCWD<CR>
nmap <silent> <leader>t :TlistToggle<CR>
nmap <silent> <leader>b :SrcExplToggle<CR>
nmap <silent> <leader>w :Bclose<CR>
nmap <silent> <leader>q :Bclose!<CR>
nmap <silent> <leader>u :GundoToggle<CR>
nmap <silent> <leader>g <Plug>(easymotion-bd-w)
nmap <silent> <leader>r :set relativenumber!<CR>
let c = 1
while c < 100 
	execute "nmap <silent> <leader>" . c . " :b" . c . "<CR>"
	let c += 1
endwhile
set ignorecase
set smartcase
set number
set guifont=Consolas:h10:cANSI
set directory=$HOME//
let g:completekey = "<C-Space>"
let g:jedi#popup_on_dot = 0
let g:jedi#goto_assignments_command = ""
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = ""
let g:jedi#usages_command = ""
let g:jedi#completions_command = ""
let g:jedi#rename_command = ""
let g:EasyMotion_off_screen_search = 0
let g:EasyMotion_do_shade = 0
let g:SuperTabClosePreviewOnPopupClose = 1
let NERDTreeMouseMode = 2
let g:gundo_prefer_python3=1
let g:gundo_right=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_nr_show = 1
set completeopt=longest,menuone,preview
"autocmd FileType python setlocal omnifunc=python3complete#Complete
autocmd FileType python setlocal omnifunc=jedi#completions
autocmd FileType python let g:SuperTabDefaultCompletionType = "context"
autocmd FileType python nmap <F5> :w !python -<CR>:redraw!<CR>

