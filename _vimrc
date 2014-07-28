set nocompatible
source $VIMRUNTIME/vimrc_example.vim

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

call pathogen#infect()
color jellybeans

set guioptions=
set nobackup
set nowritebackup
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-l> :wincmd l<CR>
nmap <silent> <C-Left> :vertical resize -1<CR>
nmap <silent> <C-Right> :vertical resize +1<CR>
nmap <silent> <C-Up> :resize -1<CR>
nmap <silent> <C-Down> :resize +1<CR>
nmap <silent> <F8> :NERDTreeToggle<CR>
nmap <silent> <F9> :TlistToggle<CR>
nmap <silent> <F10> :SrcExplToggle<CR>

set ignorecase
set smartcase
set number
let g:completekey = '<C-Tab>'
set completeopt=longest,menuone,preview
autocmd FileType python setlocal omnifunc=python3complete#Complete
autocmd FileType python let g:SuperTabDefaultCompletionType = "context"
