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
set nowrap
set cursorline
set encoding=utf-8
set guifont=DejaVu\ Sans\ Mono\ 9,Consolas:h9:cANSI
set scrolloff=2
set nostartofline
if !isdirectory($HOME."/.tmpvim/swap")
	call mkdir($HOME."/.tmpvim/swap", "p")
endif
if !isdirectory($HOME."/.tmpvim/undo")
	call mkdir($HOME."/.tmpvim/undo", "p")
endif
if has("persistent_undo")
	set undodir=$HOME/.tmpvim/undo//
	set undofile
endif
set directory=$HOME/.tmpvim/swap//
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
function! MyOpenFile()
	let filename = expand('<cfile>')
	if !empty(filename)
		execute ":FZF -e -1 -q " . expand('<cfile>') . "$"
	endif
endfunction
function! MySwitch()
	" get the current file path as a list, separated by directory
	let path_components = split(@%, '/')
	" filter out any folders with the provided names, since they'll be different for the source and header path
	call filter(path_components, 'index(["src", "cpp", "include", "libdetail"], v:val) == -1')
	" deduplicate, in case part of the path is duplicated (eg src/include/src/whatever.h)
	let dedup = filter(copy(path_components), 'index(path_components, v:val, v:key+1) == -1')
	" swap out the extension between source and header
	let source_ext = ["cpp", "c", "ipp"]
	let header_ext = ["hpp", "h"]
	if index(source_ext, expand('%:e')) != -1
		execute ":FZF -1 -q " . substitute(join(dedup, '/'), '\..*$', '', '') . "\\ " . join(header_ext, "$\\ |\\ ") . "$"
	elseif index(header_ext, expand('%:e')) != -1
		execute ":FZF -1 -q " . substitute(join(dedup, '/'), '\..*$', '', '') . "\\ " . join(source_ext, "$\\ |\\ ") . "$"
	endif
endfunction
call pathogen#infect()
autocmd ColorScheme * hi Sneak      guifg=magenta guibg=#303030 ctermfg=magenta ctermbg=236
autocmd ColorScheme * hi SneakScope guifg=magenta guibg=#303030 ctermfg=magenta ctermbg=236
autocmd ColorScheme * hi SneakLabel guifg=magenta guibg=#303030 ctermfg=magenta ctermbg=236
autocmd FileType gitcommit call setpos('.', [0, 1, 1, 0])
color jellybeans

map <MiddleMouse> <Nop>
inoremap ii <Esc>
vnoremap ii <Esc>
nmap <silent> <expr> <leader>h v:hlsearch ? ':noh<CR>' : ':set hlsearch<CR>'
nmap <silent> <leader>s :call MySwitch()<CR>
nmap <silent> <leader>w :BW<CR>
nmap <silent> <leader>q :BW!<CR>
nmap <silent> <leader>u :MundoToggle<CR>
nmap <silent> <leader>a "+
vmap <silent> <leader>a "+
nmap <silent> <leader>r :OverCommandLine<CR>%s/
vmap <silent> <leader>r :OverCommandLine<CR>s/
vmap // y/\<<C-r>"\><CR>
nmap <leader>l :set wrap! wrap?<CR>
nmap <silent> ]q :cnext<CR>
nmap <silent> [q :cprevious<CR>
nmap <silent> ]t :bn<CR>
nmap <silent> [t :bp<CR>
nmap <silent> <C-t> :FZF<CR>
nmap <silent> <leader>t :FZF %:p:h<CR>
nmap <silent> <C-b> :Buffers<CR>
nmap <silent> <C-l> :BLines<CR>
nmap <silent> <leader><C-l> :execute 'BLines '.expand("<cword>")<CR>
nmap <silent> <C-k> :Lines<CR>
nmap <silent> <leader><C-k> :execute 'Lines '.expand("<cword>")<CR>
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-l> <plug>(fzf-complete-line)
nmap <silent> gff :call MyOpenFile()<CR>
nmap s <Plug>SneakLabel_s
nmap S <Plug>SneakLabel_S
if executable('rg')
	command! -nargs=* Find Rg <args>
	command! -bang -nargs=* LFind call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>)." ".expand("%:p:h"), 1, fzf#vim#with_preview(), <bang>0)
else
	command! -nargs=* Find Ag <args>
	command! -nargs=* LFind Ag <args>
endif
" find word under cursor
nmap <silent> <leader>j :Find <C-r><C-w><CR>
" find word under cursor - case sensitive, whole world only
nmap <silent> <leader>J :execute 'Find (?-i)\b'.expand("<cword>").'\b'<CR>
" find word under cursor, only look in current buffer's directory
nmap <silent> <leader><C-j> :LFind <C-r><C-w><CR>
nmap <silent> <C-j> :execute 'LFind (?-i)\b'.expand("<cword>").'\b'<CR>
nmap <silent> <leader>g :execute 'Find ' . input('Find/')<CR>
nmap <silent> <leader><C-g> :execute 'LFind ' . input('Find/')<CR>
vmap <silent> <leader>j y:Find <C-r>"<CR>
vmap <silent> <leader>J y:execute 'Find (?-i)\b'.expand("<C-r>"").'\b'<CR>
vmap <silent> <leader><C-j> y:LFind <C-r>"<CR>
nmap <silent> <BS> <C-^>
let c=1
while c < 10
	execute "nmap <silent> <leader>" . c . " :b" . c . "<CR>"
	execute "nmap <silent> <leader>0" . c . " :b" . c . "<CR>"
	let c += 1
endwhile
while c < 100
	execute "nmap <silent> <leader>" . c . " :b" . c . "<CR>"
	let c += 1
endwhile
command TS execute ':silent !tig status' | execute ':silent redraw!'
command TB execute ':silent !tig blame -C +'.line('.').' -- %' | execute ':silent redraw!'
command TL execute ':silent !tig' | execute ':silent redraw!'
command TF execute ':silent !tig -- %' | execute ':silent redraw!'
command GC execute ':silent !git commit -v' | execute ':silent redraw!'
command GL execute ':!git ln 30'
let g:mundo_prefer_python3=1
let g:mundo_preview_bottom = 1
let g:mundo_right=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#fnamemod=':t'
let g:airline#extensions#tabline#buffer_nr_show=1
set laststatus=2
let g:sneak#label=1
let g:sneak#use_ic_scs=1
let g:sneak#prompt="Sneak>"
let g:over_command_line_key_mappings={ "\<C-g>" : "\<Esc>", }
let g:fzf_layout = { 'down': '~40%' }
set completeopt=longest,menuone,preview
set mouse=
set wildmenu
set wildmode=longest:full,full
set updatetime=500
if filereadable($HOME."/.vimrclocal")
	source $HOME/.vimrclocal
endif
