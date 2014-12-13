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
    normal b
    " 'b' will stop on '>'. Special handling is required for "std::vector<Thing>"
    while (col(".") > 1) && (getline(".")[col(".")-1] =~# "[&*>]") || (expand("<cword>") ==# "const")
        normal b
    endwhile
    let r = expand("<cword>")
    call winrestview(win_save_values)
    return r
endfunction

function! s:camel_case_name_as_list_of_words(camel_case_name)
    return map(split(a:camel_case_name, '\ze[A-Z]'), 'tolower(v:val)')
endfunction


" XXX It could be nice to map Ctrl-space: Use "<NUL>" instead of uu below
inoremap <unique> uu <Esc>:call <SID>name_object_after_its_type()<CR>a
