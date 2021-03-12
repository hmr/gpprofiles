" Part of GPP(General Puropose Profiles)
" vim: ft=vim ts=2 sts=2 sw=2 expandtab fenc=utf-8 ff=unix
" ORIGIN: 2021-03-01 by hmr

scriptencoding utf-8

"=============================================================================
" Settings for vim-plug
"=============================================================================
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  augroup vimplug_g
    autocmd!
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  augroup END
endif

"=============================================================================
" Plugins
"=============================================================================
call plug#begin('~/.vim/plugged')
" Plugins listed below will be treated by vim-plug.

" Color Schemes
Plug 'altercation/vim-colors-solarized'
Plug 'tomasr/molokai'
Plug 'crusoexia/vim-monokai'
Plug 'ErichDonGubler/vim-sublime-monokai'

" Syntax
" Syntax highliting for many languages
Plug 'sheerun/vim-polyglot' " Meta plugin for many languages
Plug 'darfink/vim-plist' " macOS plist
" Plug 'gisphm/vim-gitignore' " gitignore

" A Vim plugin which shows a git diff in the sign column.
Plug 'airblade/vim-gitgutter'

" ALE (Asynchronous Lint Engine) is a plugin providing linting (syntax checking and semantic errors)
Plug 'dense-analysis/ale'

" Conquer of Completion: Make your Vim/Neovim as smart as VSCode
"Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Vim motions on speed!
"Plug 'easymotion/vim-easymotion'

" Tab completion
" Plug 'ervandew/supertab'

" A calendar application for Vim
Plug 'itchyny/calendar.vim'

" Give a visual aid to navigate marks
Plug 'jacquesbh/vim-showmarks'

" Insert or delete brackets, parens, quotes in pair
" https://github.com/jiangmiao/auto-pairs
Plug 'jiangmiao/auto-pairs'

" So to called Zen mode for vim
Plug 'junegunn/goyo.vim'

" fzf for vim
" Plug 'junegunn/fzf.vim'

" Maintained version of CtrlP
Plug 'ctrlpvim/ctrlp.vim'

" Vim plugin which manipulate gists in Vim.
Plug 'lambdalisue/vim-gista'

" A harmonic plugin of vim-gista for ctrlp.vim
Plug 'lambdalisue/vim-gista-ctrlp'

" search and display information from arbitrary sources like files, buffers, recently used files or registers.
"Plug 'Shougo/unite.vim'

" " Denite is a dark powered plugin for Neovim/Vim to unite all interfaces
" if has('nvim')
"   Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
" else
"   Plug 'Shougo/denite.nvim'
"   Plug 'roxma/nvim-yarp'
"   Plug 'roxma/vim-hug-neovim-rpc'
" endif

" A harmonic plugin of vim-gista for unite.vim
" Plug 'lambdalisue/vim-gista-unite'

" Ctags generator for Vim
Plug 'masakuni-ito/vim-tags'

" Vim plugin for the Perl module / CLI script 'ack'
Plug 'mileszs/ack.vim'

" A Vim plugin for visually displaying indent levels in code
Plug 'nathanaelkane/vim-indent-guides'

" Better whitespace highlighting for Vim
Plug 'ntpeters/vim-better-whitespace'

" Vim plugin for intensely nerdy commenting powers
Plug 'preservim/nerdcommenter'

" A tree explorer plugin for Vim
Plug 'preservim/nerdtree'

" Vim plugin that displays tags in a window, ordered by scope
Plug 'preservim/tagbar'

"Very simple vim plugin for easy resizing of your vim windows
Plug 'simeji/winresizer'

" quickly highlight <cword> or visually selected word
Plug 't9md/vim-quickhl'

" to visually select increasingly larger regions
Plug 'terryma/vim-expand-region'

" Print Vim variables
Plug 'thinca/vim-prettyprint'

" Comment stuff out.
"Plug 'tpope/vim-commentary'

" wisely add 'end' in ruby, endfunction/endif/more in vim script, etc
Plug 'tpope/vim-endwise'

" A Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'

" '.' command enhancer
Plug 'tpope/vim-repeat'

" Automatically adjusts 'shiftwidth' and 'expandtab' heuristically
Plug 'tpope/vim-sleuth'

" All about 'surroundings': parentheses, brackets, quotes, XML tags, and more.
Plug 'tpope/vim-surround'

" Open URI with your favorite browser from your most favorite editor
Plug 'tyru/open-browser.vim'

" Lean & mean status/tabline for vim that's light as air
Plug 'vim-airline/vim-airline'

" A collection of themes for vim-airline
Plug 'vim-airline/vim-airline-themes'

" Vim documents tranlated to Japanese
Plug 'vim-jp/vimdoc-ja'

" Set 'wildignore' from ./.gitignore
Plug 'vim-scripts/gitignore'

" Syntax checking hacks for vim
" Plug 'vim-syntastic/syntastic'

" smooth scrolling to the Vim world!
"Plug 'yuttie/comfortable-motion.vim'

" vimproc is a great asynchronous execution library for Vim.
" Plug 'Shougo/vimproc.vim', {'do' : 'make'}

call plug#end()