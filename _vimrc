set rtp+=~/.fzf
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
function! SetGitDir()
	" Change working dir to the current file
	cd %:p:h
	"         " Set 'gitdir' to be the folder containing .git
	let gitdir=system("git rev-parse --show-toplevel")
	" See if the command output starts with 'fatal' (if it does, not in a git repo)
	let isnotgitdir=matchstr(gitdir, '^fatal:.*')
	"                         " If it empty, there was no error. Let's cd
	if empty(isnotgitdir)
		cd `=gitdir`
	endif
endfunction
call pathogen#infect()
color jellybeans

map <MiddleMouse> <Nop>
nmap <silent> <C-Left> :vertical resize -1<CR>
nmap <silent> <C-Right> :vertical resize +1<CR>
nmap <silent> <C-Up> :resize -1<CR>
nmap <silent> <C-Down> :resize +1<CR>
nmap <silent> <C-Tab> :bn<CR>
nmap <silent> <C-S-Tab> :bp<CR>
inoremap ii <Esc>
vnoremap ii <Esc>
nmap <silent> <leader>h :noh<CR>
nmap <silent> <leader>hh :noh<CR>
nmap <silent> <leader>s :FSHere<CR>
nmap <silent> <leader>n :NERDTreeToggle<CR>
nmap <silent> <leader>m :NERDTreeCWD<CR>
nmap <silent> <leader>w :BW<CR>
nmap <silent> <leader>q :BW!<CR>
nmap <silent> <leader>u :GundoToggle<CR>
nmap <silent> <leader>a "+
vmap <silent> <leader>a "+
nmap <silent> <leader>r :OverCommandLine<CR>%s/
vmap <silent> <leader>r :OverCommandLine<CR>s/
nmap <leader>l :set wrap! wrap?<CR>
nmap <silent> ]q :cnext<CR>
nmap <silent> [q :cprevious<CR>
nmap <silent> ]t :bn<CR>
nmap <silent> [t :bp<CR>
nmap <silent> <C-t> :FZF<CR>
nmap <silent> <C-b> :Buffers<CR>
nmap <silent> <C-l> :Lines<CR>
nmap <silent> <C-k> :BLines<CR>
nmap <silent> <C-j> :Lines <C-r><C-w><CR>
nmap <silent> <leader>j :Ag <C-r><C-w><CR>
nmap <silent> <BS> <C-^>
let c=1
while c < 10
	execute "nmap <silent> <leader>0" . c . " :b" . c . "<CR>"
	let c += 1
endwhile
while c < 100
	execute "nmap <silent> <leader>" . c . " :b" . c . "<CR>"
	let c += 1
endwhile
let NERDTreeMouseMode=2
let g:gundo_prefer_python3=1
let g:gundo_right=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#fnamemod=':t'
let g:airline#extensions#tabline#buffer_nr_show=1
set laststatus=2
let g:sneak#label=1
let g:sneak#use_ic_scs=1
let g:sneak#target_labels="asdfjkl;ghqweruioptyvnASDFJKLWERTOIU"
let g:over_command_line_key_mappings={ "\<C-g>" : "\<Esc>", }
let g:gitgutter_sign_added='●'
let g:gitgutter_sign_removed='●'
let g:gitgutter_sign_modified='●'
let g:gitgutter_sign_modified_removed='●_'
let g:gitgutter_sign_removed_first_line='^^'
set completeopt=longest,menuone,preview
set mouse=
set wildmenu
set wildmode=longest:full,full
set updatetime=500
