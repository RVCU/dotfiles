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
nnoremap <leader>nr :set nu! relativenumber!<CR>

" Run current class file with passing classpath prepend as first arg and
" method args as following args
function Run_Java_Class_Main(...)
    let arguments = BuildCommandLineForJava(a:000)
    let classpath = arguments[0]
    let class_name = arguments[1]
    let vm_args = arguments[2]
    let cli_args = arguments[3]
    execute 'Do java -cp' shellescape(classpath) vm_args class_name cli_args
endfunction

command! -nargs=* JavaRun call Run_Java_Class_Main(<f-args>)

function DebugJava(...)
    let arguments = BuildCommandLineForJava(a:000)
    let classpath = arguments[0]
    let class_name = arguments[1]
    let vm_args = arguments[2]
    let cli_args = arguments[3]
    let all_args = join([cli_args, vm_args], ' ')
    call vebugger#jdb#start(class_name,{'classpath':classpath,'srcpath':expand('%:p:h'),'args':all_args})
endfunction

command! -nargs=* DBG call DebugJava(<f-args>)

function BuildCommandLineForJava(...)
    let arguments = a:1
    let maven_classpath = javacomplete#server#GetClassPath()
    let class_name = javacomplete#collector#GetPackageName(). '.' .expand('%:t:r')
    let method_name = trim(tagbar#currenttag('%s','No current tag', ''), '()')
    let vm_args = ParseJavaCli(arguments)[0]
    let cli_args = ParseJavaCli(arguments)[1]
    let cp_args = ParseJavaCli(arguments)[2]
    if cp_args != ""
        let maven_classpath = join([cp_args, maven_classpath], ':')
    endif
    if Is_Test() != 0
        echom "Running test"
        let junit_file_path = Create_Test_XML(class_name, method_name)
        let class_name = "org.testng.TestNG"
        let cli_args = join([junit_file_path, cli_args], ' ')
    endif
    let arguments = [maven_classpath, class_name, vm_args, cli_args]
    return arguments
endfunction

function ParseJavaCli(...)
    let arguments = join(a:1,' ') " Making all the args one string seperated by spaces
    let vm_arguments = split(arguments, '-vm=') " splitting on flags and keeping the flags
    let cli_arguments = split(arguments, '-cli=') " splitting on flags and keeping the flags
    let cp_arguments = split(arguments, '-cp=') " splitting on flags and keeping the flags

    let cli_args = ""
    let vm_args = ""
    let cp_args = ""
    for vm_arg in vm_arguments
        let matcher = match(vm_arg, '\(-cli=\|-cp=\)')
        if matcher != -1 " -cli args leftovers in the vm_arg 
            let vm_arg = strcharpart(vm_arg, 0, matcher)
        endif
        let vm_args = join([vm_args, vm_arg], ' ')
    endfor
    for cli_arg in cli_arguments
        let matcher = match(cli_arg, '\(-vm=\|-cp=\)') " Returns index of match or -1
        if matcher != -1 " -vm args leftovers in the cli_arg 
            let cli_arg = strcharpart(cli_arg, 0, matcher)
        endif
        let cli_args = join([cli_args, cli_arg], ' ')
    endfor
    for cp_arg in cp_arguments
        let matcher = match(cp_arg, '\(-vm=\|-cli=\)') " Returns index of match or -1
        if matcher != -1 " -vm args leftovers in the cli_arg 
            let cp_arg = strcharpart(cp_arg, 0, matcher)
        endif
        let cp_args = join([cp_args, cp_arg], ' ')
    endfor
    let arguments = [vm_args, cli_args, cp_args]
    return arguments
endfunction

command! -nargs=* DebugJava call DebugTestNG(<f-args>)

function Is_Test() " returns true if has @Test annotation in 3 lines above class
    let old_line_number = line(".")
    :execute "normal! [m3k"
    let match_test_annotation = search('@Test', 'c', line(".")+3)
    if match_test_annotation != 0
        let is_test=1
    else
        let is_test=0
    endif
    call cursor(old_line_number, 0)
    return is_test
endfunction

function Create_Test_XML (class_name, method_name)
    let junit_file_path = getcwd() . "/.junit.xml"
    :silent execute "! cp -f ~/.vim/templates/junit.xml"  junit_file_path
    :silent execute "! sed -i 's|CLASS_NAME|". a:class_name . "|g'" junit_file_path
    :silent execute "! sed -i 's|METHOD_NAME|". a:method_name . "|g'" junit_file_path
    :redraw!
    return junit_file_path
endfunction
