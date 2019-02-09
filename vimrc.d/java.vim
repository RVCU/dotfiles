" Commands & compilation
autocmd FileType java nnoremap <C-b> :Dispatch! <cr>
autocmd FileType java let b:dispatch = 'mvn -T 1C compile -am -Dmaven.test.skip=true'
let g:completor_java_omni_trigger = "\\w+$|[\\w\\)\\]\\}'\"]+\\.\\w*$"
" java-complete2 stuff
autocmd FileType java setlocal omnifunc=javacomplete#Complete
nmap <F4> <Plug>(JavaComplete-Imports-AddSmart)
imap <F4> <Plug>(JavaComplete-Imports-AddSmart)
nmap <F5> <Plug>(JavaComplete-Imports-Add)
imap <F5> <Plug>(JavaComplete-Imports-Add)
nmap <F6> <Plug>(JavaComplete-Imports-AddMissing)
imap <F6> <Plug>(JavaComplete-Imports-AddMissing)
nmap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)
imap <F7> <Plug>(JavaComplete-Imports-RemoveUnused)

