scriptencoding utf-8

if has('vim_starting')
  if &compatible
    set nocompatible
  endif

  let neobundle_readme=expand('~/.vim/bundle/neobundle.vim/README.md')
  if !filereadable(neobundle_readme)
    echo "Installing NeoBundle..."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone 'https://github.com/Shougo/neobundle.vim' ~/.vim/bundle/neobundle.vim
  endif

  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

set noswapfile
set nomodeline  " security: see Gentoo bug #14088 and bug #73715
set backspace=indent,eol,start
set hidden
set encoding=utf-8
set termencoding=utf-8

set nopaste
set pastetoggle=<F8>
syn on

if has("autocmd")
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
endif  " restore last cursor position in the file

set autoindent
set smartindent
set shiftround
"set tabstop=8
"set softtabstop=4
"set shiftwidth=4
set smarttab
set expandtab

set listchars=tab:▒░,trail:▓,nbsp:␣
set list
set virtualedit=block
set showcmd

map <F1> <Esc>
imap <F1> <Esc>

set wmh=0
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
set splitbelow
set splitright
set laststatus=2

noremap <C-h> :tabp<CR>
noremap <C-l> :tabn<CR>


" sane movement with wrap turned on
noremap j gj
noremap k gk
noremap <Down> gj
noremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" center screen when iterating over search results
noremap n nzz
noremap N Nzz

set statusline=%<\ %n\ %f\ %{exists('g:loaded_fugitive')?fugitive#statusline():''}%m%r%y%=\ %l\/\%L\ \|%v\|\ 

vnoremap > >gv
vnoremap < <gv

set wildmenu
set wildmode=longest:full,full
set wildignore=*.swp,*.bak
set wildignore+=*.pyc
set wildignore+=*/.git/**/*,*/.hg/**/*,*/.svn/**/*
set wildignore+=tags
set wildignorecase

set scrolloff=3

set gdefault
set hlsearch
set incsearch
set ignorecase
set smartcase
nmap <Leader>q :nohl<CR>


set formatoptions-=o

" copy filename
noremap <silent> gyf :let @+ = expand("%")<CR>


if has("gui_running") || &t_Co == 88 || &t_Co == 256
    set mouse=a

    if has('mouse_sgr')
        set ttymouse=sgr  " allows clicking after the 223rd column
    endif

    set guioptions-=m  " hide menubar
    set guioptions-=T  " hide toolbar
    set guioptions-=r  " hide right scrollbar
    set guioptions-=L  " hide left scrollbar

    vmap <C-c> "+ygv
    vmap <C-x> c
    vmap <C-v> ""c<ESC>"+p
    imap <C-v> <C-r><C-r>+
    cmap <C-v> <C-r><C-r>+
else
    let g:inkpot_black_background=1
    let g:indent_guides_auto_colors = 0
    autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=red   ctermbg=black
    autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=green ctermbg=darkgrey
endif


"""
" Plugins
"""

"call vundle#begin()
call neobundle#begin()

"Bundle 'gmarik/vundle'
NeoBundleFetch 'Shougo/neobundle.vim'


NeoBundle 'Lokaltog/vim-easymotion'
NeoBundle 'haya14busa/vim-easyoperator-line'
let g:EasyMotion_smartcase=1
map <Leader> <Plug>(easymotion-prefix)
nmap f <Plug>(easymotion-fl)
nmap F <Plug>(easymotion-Fl)
omap f <Plug>(easymotion-fl)
omap F <Plug>(easymotion-Fl)
nmap t <Plug>(easymotion-tl)
nmap T <Plug>(easymotion-Tl)
omap t <Plug>(easymotion-tl)
omap T <Plug>(easymotion-Tl)
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
"map  n <Plug>(easymotion-next)
"map  N <Plug>(easymotion-prev)
let g:EasyMotion_startofline=0  " keep cursor column for j/k

NeoBundle 'nathanaelkane/vim-indent-guides'
let g:indent_guides_enable_on_vim_startup=0
let g:indent_guides_default_mapping=1

NeoBundle 'tpope/vim-obsession'

NeoBundle 'tpope/vim-sleuth'

NeoBundle 'gmarik/sudo-gui.vim'

NeoBundle 'tomtom/tcomment_vim'

NeoBundle 'godlygeek/tabular'

NeoBundle 'scrooloose/nerdtree'
let g:NERDTreeSortOrder = ['*', '\.swp$', '\.bak$', '\~$']  " Do not put dirs first
nmap ,m :NERDTreeToggle<CR>
nmap ,n :NERDTreeFind<CR>

NeoBundle 'junegunn/goyo.vim'
let g:goyo_width = 120
NeoBundle 'junegunn/limelight.vim'
let g:limelight_default_coefficient = '0.7'
let g:limelight_conceal_guifg = '#777777'
function! s:goyo_enter()
  set noshowmode
  set noshowcmd
  set scrolloff=999
  let g:neomake_open_list = 0
  Limelight
endfunction
function! s:goyo_leave()
  set showmode
  set showcmd
  set scrolloff=5
  let g:neomake_open_list = 1
  Limelight!
endfunction
autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()
map <F11> :Goyo<CR>

NeoBundle 'rickhowe/diffchar.vim'


"Bundle 'scrooloose/syntastic'
"let g:syntastic_haskell_ghc_mod_args='-g -fno-warn-missing-signatures -g -fno-warn-name-shadowing'
NeoBundle 'benekastah/neomake'
autocmd! BufWritePost * Neomake
let g:neomake_open_list = 0
let g:neomake_haskell_enabled_makers = ['hdevtools']
autocmd ColorScheme *
  \ hi link NeomakeError SpellBad |
  \ hi link NeomakeWarning SpellCap
"let g:neomake_logfile = '/tmp/neomake.log'


NeoBundle 'Shougo/vimproc.vim', {
\ 'build': {
\   'mac' : 'make -f make_mac.mak',
\   'linux': 'make',
\   'unix': 'gmake',
\   }
\ }

"NeoBundle 'eagletmt/ghcmod-vim'
"NeoBundle 'bitc/vim-hdevtools'
"autocmd FileType haskell nnoremap <buffer> <C-c><C-t> :HdevtoolsType<CR>
"autocmd FileType haskell nnoremap <buffer> <silent> <C-c><C-q> :HdevtoolsClear<CR>


NeoBundle 'tpope/vim-fugitive'

NeoBundle 'mattn/webapi-vim'
NeoBundle 'mattn/gist-vim'
let g:gist_update_on_write=2  " Update gists on :w!

"Bundle 'kien/ctrlp.vim'
""let g:ctrlp_working_path_mode='rc'
"let g:ctrlp_by_filename=1
"let g:ctrlp_clear_cache_on_exit=0
"nmap <C-b> :CtrlPBuffer<CR>
"imap <C-b> <ESC>:CtrlPBuffer<CR>

NeoBundle 'Shougo/unite.vim'
" Like ctrlp.vim settings.
nmap <C-p> :<C-u>Unite -start-insert -winheight=10
\                      -direction=botright -buffer-name=files
\                      buffer bookmark file_rec/git<CR>
let g:unite_source_history_yank_enable = 1
nnoremap <leader>y :<C-u>Unite history/yank<CR>


NeoBundle 'tpope/vim-git'
"Bundle 'plasticboy/vim-markdown'
NeoBundle 'vim-pandoc/vim-pandoc'
set spellfile=~/.config/vim/spell/ru.utf-8.add,~/.config/vim/spell/en.utf-8.add
"let g:pandoc#spell#default_langs=['en', 'ru']
set spelllang=en,ru
NeoBundle 'vim-pandoc/vim-pandoc-syntax'
NeoBundle 'ap/vim-css-color'
NeoBundle 'kchmck/vim-coffee-script'
NeoBundle 'kongo2002/fsharp-vim'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'derekwyatt/vim-scala'
NeoBundle 'rust-lang/rust.vim'
NeoBundle 'LnL7/vim-nix'

NeoBundle 'wlangstroth/vim-racket'

"call vundle#end()
call neobundle#end()
filetype plugin indent on  " required by Vundle

NeoBundleCheck

set vb
set t_vb=  " No bell

colorscheme inkpot

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/
