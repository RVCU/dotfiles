filetype on
colorscheme deus
let g:airline_theme='wombat'

augroup ft_rb
    au!
    " fixing slow syntax linting for ruby
    au Filetype ruby setlocal norelativenumber nocursorline re=1
augroup END

" enabling true colors
if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endi

"Apparently needed
set encoding=utf-8
set tabstop=4 shiftwidth=4 expandtab
set background=dark

" Set the filetype based on the file's extension, but only if
" 'filetype' has not already been set
au BufRead,BufNewFile *.jenkinsfile setfiletype groovy
au BufRead,BufNewFile *.sls setfiletype yaml

" Setting numbers on
set number
