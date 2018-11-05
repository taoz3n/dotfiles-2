if has('vim_starting')
    " Be iMproved
    set nocompatible
endif


" Load vim-plug
if empty(glob("~/.vim/autoload/plug.vim"))
    execute '!curl -fLo ~/.vim/autoload/plug.vim https://raw.github.com/junegunn/vim-plug/master/plug.vim'
endif

" Plugged System
call plug#begin('~/.vim/plugged')

" Bundles to install
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'https://gitlab.com/yorickpeterse/happy_hacking.vim'
Plug 'vim-syntastic/syntastic'  " Syntax plugin
Plug 'nvie/vim-flake8'          " PEP 8 checking
Plug 'scrooloose/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-fugitive'       " Git integration
Plug 'itchyny/lightline.vim'    " Powerline clone
Plug 'terryma/vim-multiple-cursors'

Plug 'sheerun/vim-polyglot'
Plug 'Valloric/YouCompleteMe'

" Python
Plug 'hdima/python-syntax'
Plug 'vim-scripts/indentpython.vim', { 'for': 'python' }
Plug 'hynek/vim-python-pep8-indent'
Plug 'davidhalter/jedi-vim'
Plug 'jmcantrell/vim-virtualenv'
Plug 'janko-m/vim-test'
Plug 'vim-syntastic/syntastic'

call plug#end()

" Set Splits
set splitbelow
set splitright

" Simple vimrc
set formatoptions+=t
let python_highlight_all=1
:set linebreak
:set showbreak=+++
:set hlsearch

" Colorscheme
syntax enable
set background=dark
colorscheme happy_hacking

" Automatically load a file changed outside
set autoread

" Enable autoindent
set autoindent

" Highlight current line
set cursorline

" Show line numbers
set number

" Show relative line numbers
set relativenumber

" Enable mouse support in terminal
set mouse=a

" Always show cursor postion
set ruler

" Maximum width of text that is being inserted
set textwidth=79

" Show the filename in the window titlebar
set title

" Tab stuff
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set shiftround
set smarttab

" NERDTreeToggle shorthand
cnoreabbrev NTO NERDTreeToggle

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Open splits at bottom
set splitbelow

" Open vertical splits at right
set splitright

" Smart way to move between buffers
map <M-D-Right> :tabnext<cr>
imap <M-D-Right> <esc>:tabnext<cr>a
map <M-D-Left> :tabprevious<cr>
imap <M-D-Left> <esc>:tabprevious<cr>a


" Set UTF-8
set encoding=utf-8


" Syntastic
let g:syntastic_python_checkers = ['pylint']
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Prefer pytest whenever it is available
if executable('py.test')
    let test#python#runner = 'pytest'
    let test#python#pytest#options = '-v'
endif

" Strip trailing whitespace
function! Preserve(command)
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    execute a:command
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction

" Map to strip trailing whitespace
nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>

if has('autocmd')
    "Auto source .vimrc file when save it
    autocmd! BufWritePost .vimrc source $MYVIMRC

    " Strip trailing whitespace on save
    autocmd! BufWritePre * :call Preserve("%s/\\s\\+$//e")

    autocmd FileType css,html,htmldjango setlocal shiftwidth=2 tabstop=2 softtabstop=2

    " Set spell on git commit messages
    autocmd FileType gitcommit setlocal spell

    " Better editing options for reStructuredText files
    autocmd FileType rst setlocal spell
endif
