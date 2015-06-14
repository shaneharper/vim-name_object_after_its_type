" vim-name_object_after_its_type
" Author: Shane Harper <shane@shaneharper.net>

if exists("g:loaded_name_object_after_its_type") | finish | endif
let g:loaded_name_object_after_its_type = 1


function! s:name_object_after_its_type()
    let r = join(s:camel_case_name_as_list_of_words(s:get_type_name_behind_cursor()), '_')
    if col(".") >= 2 && getline(".")[col(".")-1] =~# '[^ \t]'
        execute "normal a "
    endif
    execute "normal a".r
endfunction

function! s:get_type_name_behind_cursor()
    let win_save_values = winsaveview()
    " For "X<Y>" this will stop on Y - XXX perhaps X would make more sense?
    while (col(".") > 1) && (s:character_under_cursor() =~# "[&*>\t ]") || (expand("<cword>") ==# "const")
        normal b
    endwhile
    if s:character_under_cursor() ==# '}'  " handle "struct S { int x,y; }"
        normal %b
        if getline('.')[:col('.')-1] =~# ' : '
            execute "normal / : \<CR>b"
        endif
    endif
    let r = expand("<cword>")
    call winrestview(win_save_values)
    return r
endfunction

function! s:character_under_cursor()
    return getline('.')[col('.')-1]
endfunction

function! s:camel_case_name_as_list_of_words(camel_case_name)
    return map(split(a:camel_case_name, '\ze[A-Z]'), 'tolower(v:val)')
endfunction


" XXX It could be nice to map Ctrl-space: Use "<NUL>" instead of uu below
inoremap <unique> uu <Esc>:call <SID>name_object_after_its_type()<CR>a
