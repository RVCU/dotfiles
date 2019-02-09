" Populating any new shell files with skeleton 
if has("autocmd")              
  augroup templates            
    autocmd BufNewFile *.sh 0r ~/.vim/templates/skeleton.sh 
  augroup END                  
endif

autocmd FileType sh nnoremap <C-u> :!clear; bash % <cr>
