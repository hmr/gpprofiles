set encoding=utf-8
set fileencodings=ucs-bom,iso-2022-jp-3,iso-2022-jp,eucjp-ms,euc-jisx0213,euc-jp,sjis,cp932,utf-8

set nocompatible	" Use Vim defaults (much better!)
set bs=indent,eol,start		" allow backspacing over everything in insert mode
set ai			" always set autoindenting on
"set backup		" keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time

" Additional settings by hmr
" see more settings at: http://www.geek.sc/archives/977
set cursorline
set number
set laststatus=2
set statusline=%F%r%h%=
set incsearch
set ignorecase
set showmatch
set showmode
set title
set nowritebackup
set nobackup
set virtualedit=block
set whichwrap=b,s,[,],<,>
set backspace=indent,eol,start
set ambiwidth=double
set wildmenu
set noerrorbells
set novisualbell
set visualbell t_vb=
set list
set listchars=tab:^\ ,trail:~

syntax on
set hlsearch
" colorscheme default
colorscheme molokai


" Only do this part when compiled with support for autocommands
if has("autocmd")
  augroup redhat
  autocmd!
  " In text files, always limit the width of text to 78 characters
  autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
  " don't write swapfile on most commonly used directories for NFS mounts or USB sticks
  autocmd BufNewFile,BufReadPre /media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp
  " start with spec file template
  autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
  augroup END
endif

if has("cscope") && filereadable("/usr/bin/cscope")
   set csprg=/usr/bin/cscope
   set csto=0
   set cst
   set nocsverb
   " add any database in current directory
   if filereadable("cscope.out")
      cs add cscope.out
   " else add database pointed to by environment
   elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
   endif
   set csverb
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

filetype plugin on

if &term=="xterm"
     set t_Co=8
     set t_Sb=[4%dm
     set t_Sf=[3%dm
endif

if &term=="xterm-256color"
     set t_Co=256
     set t_Sb=^[[4%dm
     set t_Sf=^[[3%dm
endif


" Don't wake up system with blinking cursor:
" http://www.linuxpowertop.org/known.php
let &guicursor = &guicursor . ",a:blinkon0"

" Enable/Disable line number by Ctrl-M
" https://qiita.com/smison/items/f392037f1164eba5cc74
function Setnumber()
  if &number
    setlocal nonumber
  else
    setlocal number
  endif
endfunction
" nnoremap <silent> <C-m> :call Setnumber()<CR>
nmap <C-m> :call Setnumber()<CR>

" Clear hlsearch by Ctrl-L
" http://d.hatena.ne.jp/h1mesuke/20080327/p1
noremap<Esc><Esc>:nohlsearch<Cr>

