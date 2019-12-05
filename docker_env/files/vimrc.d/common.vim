filetype on
colorscheme seoul256
let g:airline_theme='wombat'

"Apparently needed
set encoding=utf-8
set tabstop=4 shiftwidth=4 expandtab
set background=dark

"Diff colours
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17 gui=none guifg=bg guibg=Red
highlight DiffText   cterm=bold ctermfg=10 ctermbg=88 gui=none guifg=bg guibg=Red

"highlight pattern for code blocks
hi MatchParen cterm=none ctermbg=green ctermfg=blue


" Set the filetype based on the file's extension, but only if
" 'filetype' has not already been set
au BufRead,BufNewFile *.jenkinsfile setfiletype groovy
au BufRead,BufNewFile *.sls setfiletype yaml

" Setting numbers on
set number
