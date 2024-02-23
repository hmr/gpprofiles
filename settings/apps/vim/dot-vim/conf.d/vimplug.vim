" vim: ft=vim ts=2 sts=2 sw=2 expandtab fenc=utf-8 ff=unix
" Part of GPP(General Puropose Profiles)

" ORIGIN: 2021-03-01 by hmr
" Last Update: [2024-02-24T03:32:00+0900]

scriptencoding utf-8

"=============================================================================
" Settings for vim-plug
"=============================================================================
if empty(glob($XDG_DATA_HOME.'/vim/autoload/plug.vim'))
  silent !curl -fLo ${XDG_DATA_HOME}/vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  if empty($MYVIMRC)
    let $MYVIMRC='$XDG_CONFIG_HOME/vim/vimrc'
  endif
  augroup vimplug_g
    autocmd!
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  augroup END
endif

"=============================================================================
" Plugins
"=============================================================================
call plug#begin($XDG_DATA_HOME.'/vim/plugged')

" Color Schemes:
" Plug 'altercation/vim-colors-solarized'
" Plug 'tomasr/molokai'
" Plug 'crusoexia/vim-monokai'
" Plug 'ErichDonGubler/vim-sublime-monokai'
" Plug 'sainnhe/sonokai'
" Plug 'phanviet/vim-monokai-pro'
Plug 'morhetz/gruvbox'
" Plug 'bluz71/vim-moonfly-colors'
" Plug 'joshdick/onedark.vim'
" Plug 'kaicataldo/material.vim'

" Syntax:
Plug 'sheerun/vim-polyglot'     " Meta plugin for many languages
Plug 'darfink/vim-plist'        " macOS plist
" Plug 'gisphm/vim-gitignore'   " gitignore
Plug 'b4winckler/vim-objc'      " Objective-C
Plug 'pearofducks/ansible-vim'  " Ansible YAML

" Unmanaged_plugins:
" My version of auto completion
" Plug '$XDG_CONFIG_HOME/vim/unmanaged/MyAutoCompletion'
" autodate
Plug '$XDG_CONFIG_HOME/vim/unmanaged/autodate'
" cmdex
Plug '$XDG_CONFIG_HOME/vim/unmanaged/cmdex'
" GNU Global
Plug '$XDG_CONFIG_HOME/vim/unmanaged/gtags'

" Misc:
" A Vim plugin which shows a git diff in the sign column.
Plug 'airblade/vim-gitgutter'

" ALE (Asynchronous Lint Engine) is a plugin providing linting (syntax checking and semantic errors)
Plug 'dense-analysis/ale'

" Conquer of Completion: Make your Vim/Neovim as smart as VSCode
"Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Vim motions on speed!
Plug 'easymotion/vim-easymotion'

" Jump to any location specified by two characters.
" Plug 'justinmk/vim-sneak'

" Tab completion
" Plug 'ervandew/supertab'

" A calendar application for Vim
" Plug 'itchyny/calendar.vim', { 'on': 'Calendar' }

" Give a visual aid to navigate marks
Plug 'jacquesbh/vim-showmarks'

" Insert or delete brackets, parens, quotes in pair
" https://github.com/jiangmiao/auto-pairs
Plug 'jiangmiao/auto-pairs'

" So to called Zen mode for vim
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }

" fzf for vim
" Plug 'junegunn/fzf.vim'

" A simple, easy-to-use Vim alignment plugin
Plug 'junegunn/vim-easy-align', { 'on': 'EasyAlign' }

" Maintained version of CtrlP
" Plug 'ctrlpvim/ctrlp.vim'

" Vim plugin which manipulate gists in Vim.
Plug 'lambdalisue/vim-gista'

" A harmonic plugin of vim-gista for ctrlp.vim
Plug 'lambdalisue/vim-gista-ctrlp'

" search and display information from arbitrary sources like files, buffers, recently used files or registers.
"Plug 'Shougo/unite.vim'

" Denite is a dark powered plugin for Neovim/Vim to unite all interfaces
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

" Vim frontend for the programmer's search tool 'ack' which is grep-like text finder
Plug 'mileszs/ack.vim', { 'on': ['Ack','AckAdd', 'AckFile', 'AckFromSearch', 'AckHelp', 'AckWindow', 'LAck', 'LAckAdd', 'LAckHelp', 'LAckWindow'] }

" A Vim plugin for visually displaying indent levels in code
Plug 'nathanaelkane/vim-indent-guides'

" Better whitespace highlighting for Vim
Plug 'ntpeters/vim-better-whitespace'

" Vim plugin for intensely nerdy commenting powers
Plug 'preservim/nerdcommenter'

" A tree explorer plugin for Vim
Plug 'preservim/nerdtree', { 'on': 'NERDTreeToggle' }

" Vim plugin that displays tags in a window, ordered by scope
Plug 'preservim/tagbar', { 'on': 'TagbarToggle' }

"Very simple vim plugin for easy resizing of your vim windows
Plug 'simeji/winresizer', { 'on': ['WinResizerStartFocus', 'WinResizerStartMove', 'WinResizerStartResize'] }

" quickly highlight <cword> or visually selected word
Plug 't9md/vim-quickhl'

" to visually select increasingly larger regions
Plug 'terryma/vim-expand-region'

" print vim variables
Plug 'thinca/vim-prettyprint', { 'on': 'PrettyPrint' }

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
" Plug 'tyru/open-browser.vim'

" Lean & mean status/tabline for vim that's light as air
Plug 'vim-airline/vim-airline'

" A collection of themes for vim-airline
Plug 'vim-airline/vim-airline-themes'

" Vim documents tranlated to Japanese
Plug 'vim-jp/vimdoc-ja'

" Set 'wildignore' from ./.gitignore
" Plug 'vim-scripts/gitignore'

" Set 'wildignore' from git repo root or home folder
Plug 'hmr/vim-rootignore' "was once 'octref/RootIgnore'

" Syntax checking hacks for vim
" Plug 'vim-syntastic/syntastic'

" smooth scrolling to the Vim world!
"Plug 'yuttie/comfortable-motion.vim'

" vimproc is a great asynchronous execution library for Vim.
" Plug 'Shougo/vimproc.vim', {'do' : 'make'}

" CSV handling plugin
Plug 'chrisbra/csv.vim'

" Elegant buffer explorer - takes very little screen space
" Plug 'fholgado/minibufexpl.vim'
" Plug 'weynhamz/vim-plugin-minibufexpl'

" Provides an easy access to a list of recently opened/edited files
" Plug 'yegappan/mru', { 'on': ['MRU', 'MRUToggle'] }
Plug 'fuenor/mru', { 'on': ['MRU', 'MRUToggle'] }

" Print function name in editing
Plug 'tyru/current-func-info.vim'

" Snippet plugin
" Plug 'SirVer/ultisnips'

" Generic snippets
Plug 'honza/vim-snippets'

" editorconfig-vim
Plug 'editorconfig/editorconfig-vim'

" ActivityWatch Watcher for vim
Plug 'ActivityWatch/aw-watcher-vim'

" Automatically set setcellwidths()
Plug 'rbtnn/vim-ambiwidth'

call plug#end()
