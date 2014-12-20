" Run this from a shell:
"  vim -S test.vim

set noswapfile
set noexpandtab

let failure_count = 0

try

for [type_name, expected_object_name] in
    \ [["SpaceStation", " space_station"],
    \  ["SpaceStation ", "space_station"],
    \  ["SpaceStation  ", "space_station"],
    \  ["SpaceStation\t", "space_station"],
    \  ["void launch(SpaceStation&", " space_station"],
    \  ["SpaceStation*", " space_station"],
    \  ["SpaceStation* const", " space_station"],
    \  ["/*XXX It'd be nice if 'space_stations' (plural) was output.*/ std::vector<SpaceStation>", " space_station"]
    \ ]
" XXX   \  ["MyThing<int>", " my_thing"]
" XXX   \  ["IBM_Computer", " IBM_computer"]
    execute 'normal i'.type_name."uu"
    normal "aY
    if @a !=# type_name.expected_object_name."\n"
        let failure_count += 1
        execute "normal A\<CR>\<CR>"
    else
        delete
    endif
endfor

if failure_count == 0
    echomsg "Ok."
    set t_ti= t_te=  " (don't restore old text displayed in terminal on exit)
    messages
    quitall!
endif

echomsg string(failure_count)." failed."

catch
    echomsg v:exception
endtry
