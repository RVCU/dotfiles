" Populating any new shell files with skeleton 
if has("autocmd")              
  augroup templates            
    autocmd BufNewFile *.sh 0r ~/.vim/templates/skeleton.sh 
  augroup END                  
endif

"set makeprg=shellcheck\ -f\ gcc\ %
autocmd Filetype sh setlocal makeprg=shellcheck\ -f\ gcc\ %
au BufWritePost * :silent make | redraw!
au QuickFixCmdPost [^l]* nested cwindow
au QuickFixCmdPost    l* nested lwindow

