" ~/.vimrc
" Thayer Williams - http://cinderwick.ca

" general
" -------

set t_Co=256
set spelllang=en_ca " Canadian English
set nobackup        " disable backup files (filename~)
set clipboard+=unnamed  " yank and copy to X clipboard
set encoding=utf-8  " UTF-8 encoding for all new files
set mouse=a         " allow mouse input in all modes
set ttymouse=xterm  " enable scrolling in screen (xterm2) or tmux (xterm) sessions
set backspace=2     " full backspacing capabilities (indent,eol,start)
set number          " show line numbers
set ww=b,s,h,l,<,>,[,]  " whichwrap -- left/right keys can traverse up/down
set linebreak       " attempt to wrap lines cleanly
set wildmenu        " enhanced tab-completion shows all matching cmds in a popup menu
set wildmode=list:longest,full
syntax on           " enable syntax highlighting
filetype plugin indent on   " enable filetype-sensitive plugins and indenting

" tabs and indenting
" ------------------

set noexpandtab     " don't insert spaces instead of tabs
set tabstop=4       " tabs appear as n number of columns
set shiftwidth=4    " n cols for auto-indenting
set autoindent      " auto indents next new line

" searching
" ---------

set hlsearch        " highlight all search results
set incsearch       " increment search
set ignorecase      " case-insensitive search
set smartcase       " uppercase causes case-sensitive search

" statusline (:help statusline for details)
" -----------------------------------------

set laststatus=2    " condition to show status line, 2=always.
set ruler           " show cursor position in status line
set showmode        " show mode in status line
set showcmd         " show partial commands in status line
" left: fileformat, type, encoding, RO/HELP/PREVIEW, modified flag, filepath
set statusline=%([%{&ff}]%)%(:[%{&fenc}]%)%(:%y%)\ \ %r%h%w\ %#Error#%m%#Statusline#\ %F\ 
" right: buffer num, lines/total, cols/virtual, display percentage
set statusline+=%=buff[%1.3n]\ \ %1.7c%V,%1.7l/%L\ \ [%P]

" hotkeys
" -------

" C-s to save
inoremap <C-s> <esc>:w<cr>a
nnoremap <C-s> :w<cr>

" F4 rewrap current paragraph and return cursor
map <F4> gwap

" F5 toggles paste mode
set pastetoggle=<F5>

" strip ^M linebreaks from dos formatted files
map M :%s/$//g

" autocmd rules
" -------------

if has("autocmd")
    " always jump to the last cursor position
    autocmd BufReadPost * if line("'\"")>0 && line("'\"")<=line("$")|exe "normal g`\""|endif
    autocmd BufRead *.txt set tw=72 " limit width to n cols for txt files
    autocmd BufRead /tmp/mutt-* set tw=72 ft=mail nocindent spell   " width, mail syntax hilight, spellcheck
endif
