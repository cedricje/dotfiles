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
    NeoBundle 'ronakg/quickr-cscope.vim'
    NeoBundle 'scrooloose/nerdtree'
    NeoBundle 'ctrlpvim/ctrlp.vim'
    NeoBundle 'octol/vim-cpp-enhanced-highlight'
    NeoBundle 'w0rp/ale'

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

" kaitai files as yaml
au BufRead,BufNewFile *.ksy set filetype=yaml


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
autocmd Filetype cpp setlocal ts=4 sw=4 expandtab
autocmd Filetype h setlocal ts=4 sw=4 expandtab
autocmd Filetype python setlocal ts=4 sw=4 expandtab
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

au FileType gitcommit set tw=72

"highlight trailing whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=red
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/

"go through buffers
nnoremap <Tab> :bn<CR>

set ts=4 sw=4 expandtab

"cycle between tabsettings
let g:TabSettings = [{'ts': 8, 'sw' : 8, 'expandtab' : 0},
                    \{'ts' : 4, 'sw' : 4, 'expandtab' : 1},
                    \{'ts' : 4, 'sw' : 4, 'expandtab' : 0} ]


function TabToggle()
    if !exists("b:TabIndex")
        let b:TabIndex = 0
    endif
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
nnoremap <F6> :set list!<CR>

map <F3> :NERDTreeToggle<CR>

nnoremap <F11> :!cscope -bRk<CR>:cs reset<CR>

" === unite plugin ===
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
let g:airline_exclude_preview=1

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
set laststatus=2

" === tagbar plugin ===
nnoremap <silent> <F4> :TagbarToggle<CR>
let g:tagbar_left = 1 "open tagbar on left side


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

" ctrl-p shows file, buffers and mru
let g:ctrlp_cmd = 'CtrlPMixed'



"" ale
" Set this in your vimrc file to disabling highlighting
let g:ale_set_highlights = 0
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%severity%][%code%] %s [%linter%]'

let g:ale_python_pylint_options = '--disable=missing-docstring,invalid-name,line-too-long,unused-argument --max-line-length=120 --extension-pkg-whitelist=pcapy'
let g:ale_python_flake8_options = '--max-line-length=120'

" disable ale for c
let g:ale_linters = {
        \ 'c': [],
        \'cpp': []
        \ }
