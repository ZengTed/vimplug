" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2008 Dec 17
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

"if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
"else
"  set backup		" keep a backup file
"endif
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=v
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

set is
set hls
set ru
set background=dark

set fencs=ucs-bom,utf-8,cp936,gb18030,gbk,gb2312
set expandtab
"map <F2> :! /usr/bin/python %
"map <F3> :! /usr/bin/python -m pdb %

set encoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,default,cp936

"""""""""""""""""""""""""""""""
" MY CUSTOM
" 2016.9.19
"""""""""""""""""""""""""""""""
syntax enable
syntax on
set nu
set ru
set smartindent
set cindent
set autoindent
set tabstop=4
set shiftwidth=4
set showmatch
set hlsearch
set incsearch
set et
set nocp

set ignorecase

set statusline=%1*%=[FORMAT=%2*%{&ff}:%{&fenc!=''?&fenc:&enc}%1*]\ %F\ [%l,%v][%p%%]
set laststatus=2
set clipboard=unnamed

"end of line
map - $
"first word of line
noremap 0 <s-^>
"begin of line
noremap 9 0

map do <c-f>
map up <c-b>

"taglist config
let Tlist_Show_One_File = 1
let Tlist_Use_Right_Window = 1
let Tlist_WinWidth = 30
nmap ;; :Tlist<cr>
nmap tn :tn<cr>
nmap tp :tp<cr>
set nocst

"easyMotion config
let mapleader=','
let g:EasyMotion_leader_key='<Leader>'

"nerdtree config
let NERDTreeWinSize = 30
let NERDTreeWinPos = "left"
nmap '' <ESC>:NERDTreeToggle<cr>

"visualMark config
nmap mn <F2>

"exchange p|P for paste, with '[ivn]nore'map
"nnoremap p P
"nnoremap P p

"system clipboard copy paste, with 'nore'map
noremap <Leader>y "+y
noremap <Leader>p "+p
noremap <Leader>P "+P

"按当前搜索方向的下一个和上一个
"* / 搜索时(顺序), n向下，N向上
"# ? 搜索时(倒序), N向下，n向上
"nnoremap n *
"nnoremap N #

"a.vim for c/h,cpp/h switch
nnoremap <silent> <F12> :A<CR>

"grep.vim for grep -r <key> under each directory
nnoremap <silent> <F3> :Rgrep<CR>

"cscope config
set cscopequickfix=s-,c-,d-,i-,t-,e-
nmap <C-\>c :cs find c <C-R>=expand("<cword>")<cr><cr>
nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<cr><cr>
nmap <C-\>g :cs find g <C-R>=expand("<cword>")<cr><cr>
nmap <C-\>d :cs find d <C-R>=expand("<cword>")<cr><cr>
nmap <C-\>s :cs find s <C-R>=expand("<cword>")<cr><cr>
nmap <C-n> :cnext<cr>
nmap <C-p> :cprev<cr>
nmap <F8> :copen 15<cr>
nmap <F9> :cclose<cr>

"about coding
cs add ./cscope.out
set tags=./tags,tags
"下面两行自动命令告诉 Vim，在打开项目目录下的文件时，
"tags选项中的内容要增加项目的 tags 文件的路径
"au BufEnter /root/wget-1.15/* setlocal tags+=/root/wget-1.15/tags

"颜色配色方案，可简单处理，gvim和vim都有colorscheme来做，局部自定义
colorscheme pablo 
hi LineNr ctermfg=23
hi Comment ctermfg=8 
hi Special term=bold ctermfg=12

"#######################################
"vundle设置
"#######################################
set rtp+=~/.vim/bundle/vundle/  
call vundle#begin()
Bundle 'gmarik/vundle'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
call vundle#end()
filetype plugin indent on     " required! 
"vundle设置完毕

let g:airline_theme = 'dark'
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

let g:airline_enable_branch = 1

"打开tabline功能,方便查看Buffer和切换,省去了minibufexpl插件
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1

"设置切换Buffer快捷键
nnoremap <s-tab> :bn<CR>
"nnoremap <C-s-tab> :bp<CR>
" 关闭状态显示空白符号计数
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#whitespace#symbol = '!'

let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline_symbols.branch = '⭠'
let g:airline_symbols.readonly = '⭤'
let g:airline_symbols.linenr = '⭡'

let g:airline_section_b = ''
let g:airline_section_c = '%F'





