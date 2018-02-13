scriptencoding utf-8

let plugin_dir = expand('~/.cache/nvim/plugins')
let dein_dir = plugin_dir . "/repos/github.com/Shougo/dein.vim"

if has('vim_starting')
  if &compatible
    set nocompatible
  endif

  if !filereadable(dein_dir . '/README.md')
    echo "Installing dein..."
    echo ""
    silent exec "!mkdir -p " . dein_dir
    silent exec "!git clone 'https://github.com/Shougo/dein.vim' " . dein_dir
  endif

  let &runtimepath .= "," . dein_dir
endif

if dein#load_state(plugin_dir)
  call dein#begin(plugin_dir)

  call dein#add(dein_dir)

  call dein#add('Lokaltog/vim-easymotion')
  call dein#add('haya14busa/vim-easyoperator-line')
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

  call dein#add('nathanaelkane/vim-indent-guides')
  let g:indent_guides_enable_on_vim_startup=0
  let g:indent_guides_default_mapping=1

  call dein#add('tpope/vim-obsession')

  call dein#add('tpope/vim-sleuth')

  call dein#add('gmarik/sudo-gui.vim')

  call dein#add('tomtom/tcomment_vim')

  call dein#add('godlygeek/tabular')

  call dein#add('tpope/vim-speeddating')

  call dein#add('scrooloose/nerdtree')
  let g:NERDTreeSortOrder = ['*', '\.swp$', '\.bak$', '\~$']  " Do not put dirs first
  nmap ,m :NERDTreeToggle<CR>
  nmap ,n :NERDTreeFind<CR>

  call dein#add('junegunn/goyo.vim')
  let g:goyo_width = 120
  call dein#add('junegunn/limelight.vim')
  let g:limelight_default_coefficient = '0.7'
  let g:limelight_conceal_guifg = '#777777'
  function! s:goyo_enter()
    set noshowmode
    set noshowcmd
    set scrolloff=999
    let s:old_neomake_open_list = g:neomake_open_list
    let g:neomake_open_list = 0
    Limelight
  endfunction
  function! s:goyo_leave()
    set showmode
    set showcmd
    set scrolloff=5
    let g:neomake_open_list = s:old_neomake_open_list
    Limelight!
  endfunction
  autocmd! User GoyoEnter nested call <SID>goyo_enter()
  autocmd! User GoyoLeave nested call <SID>goyo_leave()
  map <F11> :Goyo<CR>

  call dein#add('rickhowe/diffchar.vim')


  "Bundle 'scrooloose/syntastic'
  "let g:syntastic_haskell_ghc_mod_args='-g -fno-warn-missing-signatures -g -fno-warn-name-shadowing'
  call dein#add('benekastah/neomake')
  autocmd! BufWritePost * Neomake
  let g:neomake_open_list = 0
  let g:neomake_haskell_enabled_makers = ['hdevtools']
  autocmd ColorScheme *
    \ hi link NeomakeError SpellBad |
    \ hi link NeomakeWarning SpellCap
  "let g:neomake_logfile = '/tmp/neomake.log'


  call dein#add('Shougo/vimproc.vim', {'build' : 'make'})

  "call dein#add('eagletmt/ghcmod-vim')
  "call dein#add('bitc/vim-hdevtools')
  "autocmd FileType haskell nnoremap <buffer> <C-c><C-t> :HdevtoolsType<CR>
  "autocmd FileType haskell nnoremap <buffer> <silent> <C-c><C-q> :HdevtoolsClear<CR>


  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-rhubarb')

  call dein#add('mattn/webapi-vim')
  call dein#add('mattn/gist-vim')
  let g:gist_update_on_write=2  " Update gists on :w!

  "Bundle 'kien/ctrlp.vim'
  ""let g:ctrlp_working_path_mode='rc'
  "let g:ctrlp_by_filename=1
  "let g:ctrlp_clear_cache_on_exit=0
  "nmap <C-b> :CtrlPBuffer<CR>
  "imap <C-b> <ESC>:CtrlPBuffer<CR>

  call dein#add('Shougo/unite.vim')
  " Like ctrlp.vim settings.
  nmap <C-p> :<C-u>Unite -start-insert -winheight=10
  \                      -direction=botright -buffer-name=files
  \                      buffer bookmark file_rec/git<CR>
  let g:unite_source_history_yank_enable = 1
  nnoremap <leader>y :<C-u>Unite history/yank<CR>


  call dein#add('tpope/vim-git')
  "Bundle 'plasticboy/vim-markdown'
  call dein#add('vim-pandoc/vim-pandoc')
  set spellfile=~/.config/vim/spell/ru.utf-8.add,~/.config/vim/spell/en.utf-8.add
  "let g:pandoc#spell#default_langs=['en', 'ru']
  set spelllang=en,ru
  call dein#add('vim-pandoc/vim-pandoc-syntax')
  call dein#add('ap/vim-css-color')
  call dein#add('kchmck/vim-coffee-script')
  call dein#add('kongo2002/fsharp-vim')
  call dein#add('pangloss/vim-javascript')
  call dein#add('derekwyatt/vim-scala')
  call dein#add('rust-lang/rust.vim')
  call dein#add('LnL7/vim-nix')
  call dein#add('jceb/vim-orgmode')

  call dein#add('wlangstroth/vim-racket')

  call dein#end()
  call dein#save_state()
endif
" Required by dein:
filetype plugin indent on
syntax enable

if dein#check_install()
  call dein#install()
endif


set noswapfile
set hidden
set encoding=utf-8
set termencoding=utf-8

if has("autocmd")
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
endif  " restore last cursor position in the file

set expandtab
set autoindent
set smartindent
set shiftround
set tabstop=8
set softtabstop=2
set shiftwidth=2

set listchars=tab:▒░,trail:▓,nbsp:␣
set list
set virtualedit=block,onemore

set pastetoggle=<F8>

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

set vb
set t_vb=  " No bell


set formatoptions-=o
set formatoptions+=c

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

colorscheme inkpot

highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%81v.\+/
