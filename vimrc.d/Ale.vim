let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1
let g:ale_sign_column_always = 1
let g:ale_open_list = 0
let g:airline#extensions#ale#enabled = 1
let g:ale_completion_enabled = 0

let g:ale_pattern_options = {
\   '.*_cheat$': {'ale_enabled': 0},
\   '.*txt$':   {'ale_enabled': 0},
\   '.*xml':    {'ale_enabled': 0}
\}
