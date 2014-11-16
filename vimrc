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


syntax on

set listchars=eol:$,tab:>-,trail:~,extends:>,precedes:<
set number


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
