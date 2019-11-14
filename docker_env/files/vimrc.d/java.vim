" Commands & compilation
autocmd FileType java let b:dispatch = 'mvn -T 1C compile -am -Dmaven.test.skip=true'

command! -nargs=* BuildJavaModule call Build_Java_Module(<f-args>)
function Build_Java_Module (module_name)
    execute 'Dispatch mvn -T 1C install -pl' a:module_name '-am -o'
endfunction
