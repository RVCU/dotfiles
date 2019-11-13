autocmd FileType python nnoremap <buffer> <C-u> :exec '!clear; python' shellescape(@%, 1)<cr>
