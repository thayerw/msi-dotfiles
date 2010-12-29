
" ~/.vimrc
" Thayer Williams - http://cinderwick.ca

set t_Co=256
set nocompatible
set spelllang=en_ca " Canadian English
set shortmess+=I    " disable the welcome screen
set nobackup        " disable backup files (filename~)
set clipboard+=unnamed  " yank and copy to X clipboard
set encoding=utf-8  " UTF-8 encoding for all new files
set termencoding=utf-8  " force terminal encoding
set mouse=a         " allow mouse input in all modes
set ttymouse=xterm  " enable scrolling in screen (xterm2) or tmux (xterm) sessions
set backspace=2     " full backspacing capabilities (indent,eol,start)
set history=100     " 100 lines of command line history
set number          " show line numbers
set numberwidth=2   " minimum num of cols to reserve for line numbers
set showmatch       " show matching brackets (),{},[]
set ww=h,l,<,>,[,]  " whichwrap -- left/right keys can traverse up/down
set wrap            " wrap long lines to fit terminal width
set linebreak       " attempt to wrap lines cleanly
set ttyfast         " tell vim we're using a fast terminal for redraws
set autoread        " reload file if vim detects it changed elsewhere
set wildmenu        " enhanced tab-completion shows all matching cmds
set wildmode=list:longest,full
set splitbelow      " place the new split below the current file
set writebackup     " make a backup before writing a file until successful
set previewheight=5 " default height for a preview window (def:12)
syntax on           " enable syntax highlighting
filetype plugin indent on   " enable filetype-sensitive plugins and indenting

" tabs and indenting
set expandtab       " don't insert spaces instead of tabs
set tabstop=4       " tabs count for n number of columns
set softtabstop=4   " n cols in insert mode for tabs, backspaces, etc.
set shiftwidth=4    " n cols for << and >> indentations
set smarttab        " set <Tab>s according to shiftwidth
set autoindent      " auto indents next new line

" searching
set hlsearch        " highlight all search results
set incsearch       " increment search
set ignorecase      " case-insensitive search
set smartcase       " uppercase causes case-sensitive search
set wrapscan        " searches wrap back to the top of file

" statusline (:help statusline for details)
set cmdheight=1     " command line height
set laststatus=2    " condition to show status line, 2=always.
set ruler           " show cursor position in status line
set showmode        " show mode in status line
set showcmd         " show partial commands in status line
" left: fileformat, type, encoding, RO/HELP/PREVIEW, modified flag, filepath
set statusline=%([%{&ff}]%)%(:[%{&fenc}]%)%(:%y%)\ \ %r%h%w\ %#Error#%m%#Statusline#\ %F\ 
" right: buffer num, lines/total, cols/virtual, display percentage
set statusline+=%=buff[%1.3n]\ \ %1.7c%V,%1.7l/%L\ \ [%P]

" enter ex mode with a semi-colon too
nnoremap ; :
vnoremap ; :

" backspace deletes in visual mode
vnoremap <BS> d

" C-s to save
inoremap <C-s> <esc>:w<cr>a
nnoremap <C-s> :w<cr>

" F4 rewrap current paragraph and return cursor
map <F4> gwap

" F5 toggles paste mode
set pastetoggle=<F5>

" F6 toggles spell checking
nn <F6> :setlocal spell! spell?<CR> " spelling toggle

" strip ^M linebreaks from dos formatted files
map M :%s/$//g

" autocmd rules
if has("autocmd")
    " always jump to the last cursor position
    autocmd BufReadPost * if line("'\"")>0 && line("'\"")<=line("$")|exe "normal g`\""|endif

    autocmd BufRead *.txt set tw=72 " limit width to n cols for txt files
    autocmd BufRead /tmp/mutt-* set tw=72 ft=mail nocindent spell   " width, mail syntax hilight, spellcheck
endif


