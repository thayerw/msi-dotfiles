" Vim color file
" Title:    lightr256 - a light and colorful scheme for Vim
" Version:  v0.1
" Author:   Thayer Williams <thayerw@gmail.com>
"
" This theme is based on "trivial256" by drauh, which is in turn based
" on the "simple256" theme by A. Rodin.

set background=light
if version > 580
    " no guarantees for version 5.8 and below, but this makes it stop
    " complaining
    hi clear
    if exists("syntax_on")
        syntax reset
    endif
endif
let g:colors_name="lightr256"

if has('gui_running')

    " gui colorscheme
    hi Normal       guifg=#555555   guibg=#edf9fe
    hi VertSplit    guifg=#afafaf   guibg=#555555   gui=reverse
    hi Folded       guifg=#0000ff   guibg=#00afd7
    hi IncSearch    guifg=#555555   guibg=#ffaf00
    hi Visual       guifg=#000087   guibg=#ffffff   gui=reverse
    hi Comment      guifg=#555555   guibg=#dff3fc
    hi Constant     guifg=#0000ff
    hi Literal      guifg=#0000ff
    hi Identifier   guifg=#af00d7                   gui=none
    hi Keyword      guifg=#af00d7
    hi String       guifg=#ff005f
    hi Float        guifg=#af00d7
    hi Boolean      guifg=#000087
    hi Number       guifg=#000087
    hi Statement    guifg=#000087
    hi PreProc      guifg=#0000ff
    hi Type         guifg=#0000ff
    hi Special      guifg=#000087                   gui=none
    hi Underlined   guifg=#0000ff                   gui=underline
    hi Todo         guifg=#0000ff   guibg=#ffaf00   gui=none
    hi LineNr       guifg=#949494   guibg=#e4e4e4

    " hightlight real tabs
    hi Tab          guibg=#ffd7ff
    match Tab "\t"

elseif &t_Co > 255

    " 256-color scheme
    hi VertSplit    ctermfg=lightgray   ctermbg=darkgray    cterm=reverse
    hi Folded       ctermfg=blue        ctermbg=lightcyan
    hi IncSearch    ctermfg=darkgray    ctermbg=yellow
    hi Visual       ctermfg=blue        ctermbg=white       cterm=reverse
    hi Comment      ctermfg=darkgray    cterm=bold
    hi Constant     ctermfg=blue
    hi Literal      ctermfg=blue
    hi Identifier   ctermfg=magenta     cterm=none
    hi Keyword      ctermfg=magenta
    hi String       ctermfg=darkred
    hi Float        ctermfg=magenta
    hi Boolean      ctermfg=darkblue
    hi Number       ctermfg=darkblue
    hi Statement    ctermfg=darkblue
    hi PreProc      ctermfg=blue
    hi Type         ctermfg=blue
    hi Special      ctermfg=darkblue    cterm=none
    hi Underlined   ctermfg=blue        cterm=underline
    hi Todo         ctermfg=blue        ctermbg=yellow      cterm=none
    hi LineNr       ctermfg=246         ctermbg=254

    " hightlight real tabs
    hi Tab          ctermbg=225         guibg=#ffd7ff
    match Tab "\t"

elseif &t_Co < 256

    " 16/88-color scheme


endif

