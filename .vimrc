
" ~/.vimrc
" Thayer Williams - http://cinderwick.ca

" set the proper color-depth for colorscheme usage
if &term=="linux"
    set t_Co=16
    "colorscheme vimbrant
else 
    set t_Co=256
    "colorscheme calmar256-light
    "colorscheme xoria256
endif

set nocompatible
set spelllang=en_ca " Canadian English
set shortmess+=I    " disable the welcome screen
set nobackup        " disable backup files (filename~)
set clipboard+=unnamed  " yank and copy to X clipboard
"set encoding=utf-8  " UTF-8 encoding for all new files
"set termencoding=utf-8  " force terminal encoding
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
"set textwidth=72   " insert carriage return after n cols wide
syntax on           " enable syntax highlighting
filetype plugin indent on   " enable filetype-sensitive plugins and indenting

" tabs and indenting
set expandtab       " don't insert spaces instead of tabs
set tabstop=4       " tabs count for n number of columns
set softtabstop=4   " n cols in insert mode for tabs, backspaces, etc.
set shiftwidth=4    " n cols for << and >> indentations
set smarttab        " set <Tab>s according to shiftwidth
set autoindent      " auto indents next new line
set nosmartindent   " intelligent indenting -- DEPRECATED by cindent
set nocindent       " C style indenting off
set cinoptions=:0,p0,t0 " recommended defaults from O'Reilly
set cinwords=if,else,while,do,for,switch,case   " recommended defaults from O'Reilly
set formatoptions=tcqr" recommended defaults from O'Reilly

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

" html conversion (:help 2html.vim)
let g:html_use_css = 1
let g:use_xhtml = 1
let g:html_use_encoding = "utf8"
let g:html_number_lines = 1


" typo corrections
nmap q: :q<cr>

" enter ex mode with a semi-colon too
nnoremap ; :
vnoremap ; :

" backspace deletes in visual mode
vnoremap <BS> d

" C-s to save
inoremap <C-s> <esc>:w<cr>a
nnoremap <C-s> :w<cr>

" F2 selects all
"nnoremap <F2> ggVG

" F3 toggles wordwrap
"nnoremap <F3> :set invwrap wrap?<CR>

" F4 rewrap current paragraph and return cursor
map <F4> gwap

" F5 toggles paste mode
set pastetoggle=<F5>

" F6 toggles spell checking
nn <F6> :setlocal spell! spell?<CR> " spelling toggle

" F9 runs 2html conversion
map <F9> :runtime syntax/2html.vim

" strip ^M linebreaks from dos formatted files
map M :%s/$//g

" firefox style tabbing
nmap <c-t> :tabnew<cr>
" nmap <c-w> :close<cr>
map <S-h> gT
map <S-l> gt
map <a-1> 1gt
map <a-2> 2gt
map <a-3> 3gt
map <a-4> 4gt
map <a-5> 5gt
map <a-6> 6gt
map <a-7> 7gt
map <a-8> 8gt
map <a-9> 9gt
map <a-0> 10gt

" abbreviations
:iab sigc -- <CR>Thayer Williams<CR>http://cinderwick.ca/
:iab siga -- <CR>Thayer Williams<CR>Arch Linux Developer

" Option toggle function {{{
function! MapToggle(key, opt)
    let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
    exec 'nnoremap '.a:key.' '.cmd
    exec 'inoremap '.a:key." \<C-O>".cmd
endfunction
command! -nargs=+ MapToggle call MapToggle(<f-args>)

" And the commands to toggle
MapToggle <F7> number
MapToggle <F8> hlsearch
MapToggle <F3> wrap
" }}}


" gvim settings
if has ("gui_running")
    " only initialize window size if has not been initialized yet
    if !exists ("s:my_windowInitialized_variable")
        let s:my_windowInitialized_variable=1
        set guifont=Courier\ New\ 10" backslash any spaces
        "set guifont=Consolas\ 11" backslash any spaces
        "colorscheme automation256
        set guioptions-=T   " hide the toolbar
        set columns=118     " previous values: 120
        set lines=40        " previous values: 40, 32
    endif
endif

" autocmd rules
if has("autocmd")
    autocmd BufRead,BufNewFile PKGBUILD set ft=sh
    autocmd BufRead *.txt set tw=72 " limit width to n cols for txt files
    autocmd BufRead /tmp/mutt-* set tw=74 ft=mail nocindent spell   " width, mail syntax hilight, spellcheck
    autocmd BufRead /tmp/vimperator-* set tw=72 ft=mail nocindent spell   " width, mail syntax hilight, spellcheck

    " always jump to the last cursor position
    autocmd BufReadPost * if line("'\"")>0 && line("'\"")<=line("$")|exe "normal g`\""|endif

    " Read word documents
    autocmd BufReadPre *.doc set ro
    autocmd BufReadPre *.doc set hlsearch!
    autocmd BufReadPost *.doc %!antiword "%"

    au BufNewFile,BufRead *conkyrc*    set ft=conkyrc
    au BufNewFile,BufRead *muttrc*     set ft=muttrc
    au BufNewFile,BufRead *screenrc*   set ft=screen

    " tabs and indenting for code
    "autocmd BufRead,BufNewFile * set noexpandtab tabstop=8 softtabstop=8 shiftwidth=8 " kernel coding style
    "autocmd BufRead,BufNewFile *.htm,*.html,*.php,*.css set noet ts=4 sts=4 sw=4
endif


