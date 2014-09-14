" ========
" General
" ========

" we're using vim, not vi
set nocompatible

" http://superuser.com/questions/356970/smooth-scrolling-for-vim-in-mac-terminal-iterm
set mouse=niv "or set mouse=a

" set command history to 500
set history=500

set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows

" =================
" UI/Colours
" =================

" If we're using a gnome-terminal
if $COLORTERM == 'gnome-terminal'
    " then just manually set 256 colours
    " since gnome terminal doesn't like to advertise
    " it's colours :(
    set t_Co=256
endif

" use relative numbers
set number
set relativenumber

" show current position
set ruler

" height of the command bar
set cmdheight=2

" make backspace act like backspace
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Use incremental search
set incsearch

" don't redraw while executing macros (good performance config)
set lazyredraw

" for regex
set magic

" Show matching brackets when the text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" No annoying sounds on errors
set noerrorbells
set visualbell
set t_vb=
set tm=500

" Always show the status line
set laststatus=2

" ====================
" Text/editing-related
" ===================

" auto read files when changed from other programs
set autoread

" Use spaces instead of tabs
set expandtab

" Be smart when using tabs,
" namely to backspace the correct amount of spaces
set smarttab

" Set the tab width
set shiftwidth=4
set tabstop=4

" Set auto-indentation
set autoindent

" Wrap lines
set wrap

" Linebreak on 500 characters
set lbr
set tw=500

" store swap files elsewhere
set dir=~/.vim/backup/swap//,~/.vim/backup/tmp//,~/.vim/backup//,.

" Change directory to the current buffer when opening files.
set autochdir

" =============================
" Re-maps (not plugin specific)
" =============================

" normal re-map leader-p to 
" paste from the system clipboard
nmap <leader>p "+p

" insert re-map CTRL-p to paste 
" from the clipboard
imap <C-p> <C-r>+

" yank re-map for system clipboard
nmap Y "+y
nmap YY "+yy
vmap Y "+y

" toggle highlight
map <leader><cr> :set hls!<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :bd<cr>

" Close all the buffers
map <leader>ba :1,1000 bd!<cr>

" Useful mappings for managing tabs
map tn :tabnew<cr>
map to :tabonly<cr>
map tc :tabclose<cr>
map tq :tabclose<cr>
map tM :tabmove -1<cr>
map tm :tabmove +1<cr>

"" Opens a new tab with the current buffer's path
"" Super useful when editing files in the same directory
map te :tabedit <c-r>=expand("%:p:h")<cr>/

" ==============
" Plugins
" ==============

call plug#begin('~/.vim/plugged')

""" Syntax-checking/auto-completion
Plug 'Valloric/YouCompleteMe', { 'do': './install.sh --clang-completer', 'on': [] }
Plug 'scrooloose/syntastic', { 'on': 'SyntasticCheck' }

""" Snippets
Plug 'SirVer/ultisnips', { 'on': [] }
Plug 'miguelmartin75/vim-snippets'

""" Text-editing/manipulation/movement
Plug 'ervandew/supertab'
Plug 'tpope/vim-repeat'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-surround'
Plug 'joequery/Stupid-EasyMotion'
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }

""" File Browsing
Plug 'scrooloose/nerdtree', { 'on' : 'NERDTreeToggle' }
Plug 'kien/ctrlp.vim', { 'on': 'CtrlP' }

""" Lang
Plug 'moll/vim-node', { 'for' : 'javascript' }
Plug 'wting/rust.vim', { 'for' : 'rust' }

""" Git
Plug 'tpope/vim-fugitive'

""" Colour scheme
Plug 'w0ng/vim-hybrid'

call plug#end()

" ==============
" Plugin config
" ==============

augroup load_ycm
    autocmd!
    autocmd FileType c,cpp,objc,objcpp,python,cs call plug#load('YouCompleteMe') 
                                              \| call youcompleteme#Enable() 
augroup END

augroup load_insert_mode_plugs
  autocmd!
  autocmd InsertEnter * call plug#load('ultisnips')
augroup END

" NerdTree
" ----------
let g:NERDShutUp=1

let NERDTreeShowBookmarks=1
let NERDTreeIgnore=['\.DS_Store', '\.pyc', '\~$', '\.swo$', '\.swp$', '\.git', '\.hg', '\.svn', '\.bzr']
let NERDTreeChDirMode=0
let NERDTreeQuitOnOpen=1
let NERDTreeMouseMode=2
let NERDTreeShowHidden=1
let NERDTreeKeepTreeInNewTab=1
let g:nerdtree_tabs_open_on_gui_startup=0

" Ultisnips
" ---------
let g:UltiSnipsSnippetsDir = "~/.vim/bundle/vim-snippets"

" YCM
" ----

" http://stackoverflow.com/a/18685821
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'

" remove the preview window automatically
"set completeopt-=preview
let g:ycm_autoclose_preview_window_after_insertion = 1

" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" CtrlP
" ------

" have to setup a remapping 
" because with vim-plug, CtrlP is
" not initialised, lol.
nmap <c-p> :CtrlP<CR>
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'

" Hybrid
" -------

" colour scheme
if has("unix")
    let s:uname = system("uname -s")
    if s:uname == "Darwin\n"
        let g:hybrid_use_iTerm_colors = 1
    endif
endif

" must set the color scheme here, in order for vim 
" load it properly
silent! colorscheme hybrid


" ==========================
" Re-maps (plugin specific)
" ==========================

" NerdTree
" --------
map <C-e> :NERDTreeToggle<CR>:NERDTreeMirror<CR>


" Stupid-EasyMotion
" ------------------
map <C-o> <Leader><Leader>w
map <C-i> <Leader><Leader>W

" Tagbar
" ------
nmap <Leader>t :TagbarToggle<CR> 

" ==============
" Auto-commands
" ==============

" Remember info about open buffers on close
set viminfo^=%

augroup text_editing:
    autocmd!
    " Return to last edit position when opening files (You want this!)
    autocmd BufReadPost *
          \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

    autocmd FileType text,markdown setlocal spell spelllang=en_au | setlocal tw=100
augroup END
