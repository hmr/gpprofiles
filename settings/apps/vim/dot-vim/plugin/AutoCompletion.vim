scriptencoding utf-8
"=============================================================================
"    Description: 入力自動補完
"
" キーを打つごとに補完候補を表示します。
" 補完単語が無くなるか、非選択時に<C-y>で自動補完が中止になります。
" 本プラグインは指定文字数以上入力の度にVimの補完コマンドを実行して補完候補を
" 表示しています。
"
" オプション
" 補完を開始するキー入力数
" let MyAutoComplete_StartLength = 2
"
" デフォルトの補完コマンド
" let MyAutoComplete_cmd = "\<C-n>\<C-p>"
"
" デフォルト補完候補はVimのcompleteオプションに従って検索されます。
" set complete = '.,w,b,u,t,i'
" (詳細は :help 'complete')
"
" 補完候補はsmartcaseの設定値にかかわらず、smartcaseを有効にして検索されま
" す。無効にしたい場合は.vimrcに以下を設定してください。
" let MyAutoComplete_smartcase_Control = 0
"
" ファイルタイプ別に補完コマンドの設定を変更可能です。
" 以下にfiletype=cppの場合の設定を記しますので、cppの部分は任意のファイルタイ
" プに読み替えてください。
"
" ファイルタイプcppの場合のcompleteオプション
" let cpt_cpp = '.,w,b,u,t,i'
" ファイルタイプcppの場合はオムニ補完を指定 (詳細は :help 'omnifunc')
" let cptcmd_cpp = "\<C-x>\<C-o>\<C-p>"
"=============================================================================
if !exists('MyAutoComplete')
  let MyAutoComplete = 1
endif
if MyAutoComplete == 0 || exists('loaded_MyAutoComplete')
  finish
endif
let loaded_MyAutoComplete = 1

let s:cpo_save = &cpo
set cpo&vim

" smartcaseを利用して大文字小文字を区別する/しない
if !exists('MyAutoComplete_smartcase_Control')
  let MyAutoComplete_smartcase_Control = 1
endif
" 自動補完を始めるキー入力数
if !exists('MyAutoComplete_StartLength')
  let MyAutoComplete_StartLength = 2
endif
" 自動補完と折りたたみが併用されていると、入力がもたつく対策
if !exists('MyAutoComplete_Folding')
  let MyAutoComplete_Folding = 0
  if MyAutoComplete == 2
    let MyAutoComplete_Folding = 1
  endif
endif
if !has('folding')
  let MyAutoComplete_Folding = 0
endif
" デフォルト補完コマンド
if !exists('MyAutoComplete_cmd')
  let MyAutoComplete_cmd = "\<C-n>\<C-p>"
endif
let s:saved_cot = &completeopt

" 自動補完
let s:saved_cpt = &complete
function! s:AutoCompletion()
  if (g:MyAutoComplete == 0)
    return ''
  endif
  if s:acline != line('.') || col('.') > s:accol + 1
    call s:AutoCompletionInit()
    return ''
  endif
  let s:accnt = s:accnt - (s:accol - col('.'))
  if s:accnt < 0
    let s:accnt = 0
  endif
  let s:accol  = col('.')
  let s:acline = line('.')
  if s:accnt+1 >= g:MyAutoComplete_StartLength
    " exec 'set complete='.s:saved_cpt
    " exec 'set completeopt='.s:saved_cot
    if !pumvisible()
      let suffix = &ft
      set completeopt+=menuone
      if exists('g:cpt_'.suffix)
        exec 'let &complete=g:cpt_'.suffix
      endif
      if exists('g:cptcmd_'.suffix)
        exec 'let cmd = g:cptcmd_'.suffix
        return cmd
      endif
      return g:MyAutoComplete_cmd
    endif
  endif
  return ''
endfunction

function! s:AutoCompletionRegLetters(letters)
  for letter in split(a:letters,'\zs')
    exec 'inoremap <silent> <expr> ' letter ' "' . letter . '" . <SID>AutoCompletion()'
  endfor
endfunction

function! s:AutoCompletionRegKeys(start, end)
  let letter = a:start
  while letter <=# a:end
    exec 'inoremap <silent> <expr> ' letter ' "' . letter . '" . <SID>AutoCompletion()'
    let letter = nr2char(char2nr(letter)+1)
  endwhile
endfunction

" 補完に使うキーを登録する
call s:AutoCompletionRegKeys('a', 'z') " a-z
call s:AutoCompletionRegKeys('A', 'Z') " A-Z
call s:AutoCompletionRegKeys('0', '9') " 0-9
call s:AutoCompletionRegLetters('_') " _
inoremap <silent> <expr> <CR> pumvisible() ? "\<C-y>\<CR>" : "\<CR>"

augroup AutoCompletion
  autocmd!
  autocmd InsertEnter * call s:AutoCompletionEnter()
  autocmd InsertLeave * call s:AutoCompletionLeave()
augroup END

let s:saved_scs = &smartcase
let s:saved_ic = &ignorecase
function! s:AutoCompletionEnter()
  call s:AutoCompletionInit()
  if g:MyAutoComplete_smartcase_Control
    let s:saved_ic = &ignorecase
    let s:saved_scs = &smartcase
    setlocal ignorecase
    setlocal nosmartcase
  endif
  if g:MyAutoComplete_Folding
    let s:saved_fdm = &foldmethod
    setlocal foldmethod=manual
  endif
endfunction

function! s:AutoCompletionLeave()
  if g:MyAutoComplete_smartcase_Control
    exec ':setlocal ' . (s:saved_ic  ? '' : 'no') . 'ignorecase'
    exec ':setlocal ' . (s:saved_scs ? '' : 'no') . 'smartcase'
  endif
  if g:MyAutoComplete_Folding
    exec 'setlocal foldmethod='.s:saved_fdm
  endif
endfunction

function! s:AutoCompletionInit()
  let s:accnt  = 0
  let s:accol  = col('.')
  let s:acline = line('.')
endfunction

let s:accnt  = 0
let s:accol  = 0
let s:acline = 0
let s:saved_fdm = has('folding') ? &foldmethod : ''

let &cpo = s:cpo_save
unlet s:cpo_save
