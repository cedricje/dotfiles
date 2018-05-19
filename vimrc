"NeoBundle Scripts-----------------------------
if has('vim_starting')
  set nocompatible               " Be iMproved

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

    " Add or remove your Bundles here:
    "NeoBundle 'Shougo/neosnippet.vim'
    "NeoBundle 'Shougo/neosnippet-snippets'
    "NeoBundle 'kien/ctrlp.vim'
    "NeoBundle 'flazz/vim-colorschemes'
    NeoBundle 'Shougo/vimproc.vim', {
                \ 'build' : {
                \     'windows' : 'tools\\update-dll-mingw',
                \     'cygwin' : 'make -f make_cygwin.mak',
                \     'mac' : 'make -f make_mac.mak',
                \     'linux' : 'make',
                \     'unix' : 'gmake',
                \    },
                \ }
    NeoBundle 'Valloric/YouCompleteMe', {
                \ 'build' : {
                \     'linux' : './install.py --clang-completer --rust-completer',
                \     'mac' : './install.py --clang-completer --rust-completer',
                \     'unix' : './install.py --clang-completer --rust-completer',
                \     'windows' : './install.py --clang-completer --rust-completer',
                \     'cygwin' : './install.py --clang-completer --rust-completer'
                \    },
                \ }
	NeoBundle 'altercation/vim-colors-solarized'
    NeoBundle 'LaTeX-Suite-aka-Vim-LaTeX'
    NeoBundle 'Tagbar'
    NeoBundle 'vim-airline/vim-airline'
    NeoBundle 'vim-airline/vim-airline-themes'
    NeoBundle 'Shougo/unite.vim'
    NeoBundle 'tpope/vim-fugitive'
    NeoBundle 'asins/mark'
    NeoBundle 'hari-rangarajan/CCTree' " Vim CCTree plugin
    NeoBundle 'Python-mode-klen' " 0.6.2 python mode
    " You can specify revision/branch/tag.
    "NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------

" === general config ===
syntax on

"need to set this to dark to get a light background...
set background=dark
set t_ut=
set t_Co=256
set term=xterm-256color
"let g:solarized_termcolors=256
colorscheme solarized

"configure list chars
set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set number
set ffs=unix,mac,dos "file formats
set hlsearch "higlight searches
" indentation
set cindent
set autoindent
set tabstop=4
set shiftwidth=4

"set autocompletion fr some filetypes
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

"set tabsettings for some filetype
autocmd Filetype c setlocal ts=4 sw=4 expandtab
autocmd Filetype h setlocal ts=4 sw=4 expandtab
autocmd Filetype python setlocal ts=4 sw=4 expandtab
au FileType gitcommit set tw=72

"highlight trailing whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=red
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/

"go through buffers
nnoremap <Tab> :bn<CR>

"cycle between tabsettings
let b:TabIndex = 0
let g:TabSettings = [{'ts': 8, 'sw' : 8, 'expandtab' : 0},
                    \{'ts' : 4, 'sw' : 4, 'expandtab' : 1},
                    \{'ts' : 4, 'sw' : 4, 'expandtab' : 0} ]


function TabToggle()
    let l:max = len(g:TabSettings)
    let l:buf = 'TabSettings '
    let b:TabIndex = b:TabIndex + 1

    if b:TabIndex >= l:max
        let b:TabIndex = 0
    endif

    for key in keys(g:TabSettings[b:TabIndex])
        execute "let &" . key . "=g:TabSettings[b:TabIndex]['" . key . "']"
        let l:buf=l:buf . key . "=" . eval("g:TabSettings[b:TabIndex]['" . key . "']") . " "
    endfor
    echo l:buf
endfunction

noremap <silent> <F5> :call TabToggle()<CR>


" === unite plugin ===

" CtrlP search
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom_source('file_rec/async','sorters','sorter_rank')
" replacing unite with ctrl-p
nnoremap <silent> <C-p> :Unite -start-insert -buffer-name=files -winheight=10 file_rec/async<cr>

"contemt searching
if executable('ag')
  " Use ag in unite grep source.
  let g:unite_source_grep_command = 'ag'
  let g:unite_source_grep_default_opts =
  \ '-i --line-numbers --nocolor --nogroup --hidden --ignore ' .
  \  '''.hg'' --ignore ''.svn'' --ignore ''.git'' --ignore ''.bzr'''
  let g:unite_source_grep_recursive_opt = ''
elseif executable('pt')
  " Use pt in unite grep source.
  " https://github.com/monochromegane/the_platinum_searcher
  let g:unite_source_grep_command = 'pt'
  let g:unite_source_grep_default_opts = '--nogroup --nocolor'
  let g:unite_source_grep_recursive_opt = ''
elseif executable('ack-grep')
  " Use ack in unite grep source.
  let g:unite_source_grep_command = 'ack-grep'
  let g:unite_source_grep_default_opts =
  \ '-i --no-heading --no-color -k -H'
  let g:unite_source_grep_recursive_opt = ''
endif

nnoremap <space>/ :Unite grep:.<cr>


" enable history yanking
let g:unite_source_history_yank_enable = 1
nnoremap <space>y :<C-u>Unite history/yank<CR>

" === airline plugin ===
let g:airline_solarized_bg='dark'
let g:airline_powerline_fonts = 1
let g:airline_theme='solarized'
set laststatus=2

" === tagbar plugin ===
nnoremap <silent> <F4> :TagbarToggle<CR>
let g:tagbar_left = 1 "open tagbar on left side

" === pymode plugin ===
"Linting
let g:pymode_lint = 1
let g:pymode_lint_checkers = ['pylint', 'pyflakes','pep8']
" let g:pymode_lint_checker = ['pylint']
"ignore 80 characters limit
let g:pymode_lint_ignore = "E501,C"
" Auto check on save
let g:pymode_lint_write = 1

" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all

"python autocompletion
let g:pymode_rope_completion = 0
let g:pymode_rope_complete_on_dot = 0

" YouCompleteMe
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_filetype_blacklist = {
      \ 'tagbar' : 1,
      \ 'qf' : 1,
      \ 'notes' : 1,
      \ 'markdown' : 1,
      \ 'unite' : 1,
      \ 'text' : 1,
      \ 'vimwiki' : 1,
      \ 'pandoc' : 1,
      \ 'infolog' : 1,
      \ 'mail' : 1,
      \}

let g:ycm_rust_src_path = '~/src/rust/src'



