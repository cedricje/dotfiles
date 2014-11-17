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
    "NeoBundle 'tpope/vim-fugitive'
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
    NeoBundle 'LaTeX-Suite-aka-Vim-LaTeX'
    NeoBundle 'Tagbar'
    NeoBundle 'bling/vim-airline'
    NeoBundle 'Shougo/unite.vim'
    NeoBundle 'fugitive.vim'

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
autocmd Filetype python setlocal ts=4 sw=4
au FileType gitcommit set tw=72

"highlight trailing whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=red
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/

"go through buffers
nnoremap <Tab> :bn<CR>

" === unite plugin ===

" CtrlP search
call unite#filters#matcher_default#use(['matcher_fuzzy'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom_source('file_rec/async','sorters','sorter_rank')
" replacing unite with ctrl-p
nnoremap <silent> <C-p> :Unite -start-insert -buffer-name=files -winheight=10 file_rec/async<cr>

"contemt searching
nnoremap <space>/ :Unite grep:.<cr>

" enable history yanking
let g:unite_source_history_yank_enable = 1
nnoremap <space>y :<C-u>Unite history/yank<CR>

" === airline plugin ===
"let g:airline_powerline_fonts = 1
set laststatus=2
