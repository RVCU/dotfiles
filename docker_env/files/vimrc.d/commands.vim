" Miscellaneous Shortcuts
nmap <C-g> :TagbarToggle<CR>
nmap <C-n> :NERDTreeToggle<CR>
" fugitive git bindings
nnoremap <leader>ga :Git add %:p<CR><CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gc :Gcommit -v -q<CR>
nnoremap <leader>gt :Gcommit -v -q %:p<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gw :Gwrite<CR><CR>
nnoremap <leader>gl :silent! Glog<CR>:bot copen<CR>
nnoremap <leader>gp :Ggrep<Space>
nnoremap <leader>gm :Gmove<Space>
nnoremap <leader>gb :Git branch<Space>
nnoremap <leader>go :Git checkout<Space>
nnoremap <leader>gps :Dispatch! git push<CR>
nnoremap <leader>gpl :Dispatch! git pull<CR>

" Turn on and off number for file
nnoremap <leader>nr :set nu! <CR>
" Miscellaneous Shortcuts
nmap <C-g> :TagbarToggle<CR>
nmap <C-n> :NERDTreeToggle<CR>

" Run current class file with passing classpath prepend as first arg and
" method args as following args
function Run_Java_Class_Main(...)
    let arguments = BuildCommandLineForJava(a:000)
    let classpath = substitute(arguments[0],' ','',"g")
    let class_name = arguments[1]
    let vm_args = arguments[2]
    let cli_args = arguments[3]
	"let cmd = 'java -verbose -cp ' . shellescape(classpath) . vm_args . class_name . cli_args
    echom cli_args
	let cmd = 'java -cp ' . join([classpath, vm_args, class_name, cli_args], ' ')
	echom cmd
	execute term_start(cmd)
endfunction

command! -nargs=* JavaRun call Run_Java_Class_Main(<f-args>)

function DebugJava(...)
    let arguments = BuildCommandLineForJava(a:000)
    let classpath = substitute(arguments[0],' ','',"g")
    let class_name = arguments[1]
    let vm_args = arguments[2]
    let cli_args = arguments[3]
    let all_args = join([cli_args, vm_args], ' ')
    call vebugger#jdb#start(class_name,{'classpath':classpath,'srcpath':expand('%:p:h'),'args':cli_args,'system':vm_args})
endfunction

function! Install_Coc()
    :CocInstall coc-java
    sleep 30
    :CocInstall coc-python
    sleep 30
    :CocInstall coc-yaml
    sleep 31
    :CocInstall coc-go
    sleep 30
    :CocInstall coc-json
    sleep 30
    :CocInstall coc-docker
    sleep 30
    :CocInstall coc-sh
    sleep 30
    :CocInstall coc-solargraph
    sleep 30
    :CocInstall coc-highlight
endfunction  
