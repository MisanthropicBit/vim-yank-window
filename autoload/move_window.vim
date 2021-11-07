let s:yanked_buffer = -1

function! move_window#yank(quit) abort
    let s:yanked_buffer = bufnr()

    if a:quit
        if tabpagenr('$') == 1 && winnr('$') == 1
            echom 'Cannot yank and quit current window since it is the only open window'
            return
        endif

        " Close the window into the buffer, not the buffer itself
        close
    endif

    echom printf('Yanked window winnr:%d, bufnr:%d tabpage:%d', winnr(), bufnr(), tabpagenr())
endfunction

function! s:get_split_prefixes(dir, full_width) abort
    if a:dir ==# 'left'
        return 'leftabove vert'
    elseif a:dir ==# 'down'
        return 'rightbelow'
    elseif a:dir ==# 'up'
        return 'leftabove'
    elseif a:dir ==# 'right'
        return 'rightbelow vert'
    elseif a:dir ==# 'tab-after'
        return 'tab'
    elseif a:dir ==# 'tab-before'
        return '-tab'
    else
        throw printf("Unknown direction '%s'", a:dir)
    endif
endfunction

function! move_window#paste(dir, full_width) abort
    if s:yanked_buffer == -1
        echo 'No yanked buffer'
        return
    endif

    if !bufexists(s:yanked_buffer)
        echo printf("Buffer '%d' does not exist", s:yanked_buffer)
        return
    endif

    let cmd_prefix = s:get_split_prefixes(a:dir, a:full_width)

    execute printf('%s sbuffer %d', cmd_prefix, s:yanked_buffer)
    let win_id = win_getid()

    if a:full_width
        call move_window#paste_full(a:dir)
        call win_gotoid(win_id)
    endif
endfunction

" function! move_window#find_column(winid, node) abort
"     if a:node[0] ==# 'leaf'
"         if a:node[1] == a:winid
"             return 1
"         endif
"     else
"         if a:node[0] ==# 'col'
"             let col = a:node[0]
"         endif

"         for subtree in a:node[1]
"             let found = move_window#find_column(a:winid, subtree)
            
"             if !empty(found)
"                 return col
"             endif
"         endfor
"     endif
" endfunction

function! move_window#find_outermost(type, node, row_or_col, winid) abort
    if a:node[0] ==# 'leaf'
        return a:node[1] == a:winid ? a:row_or_col : []
    else
        let row_or_col = (a:node[0] ==# a:type && empty(a:row_or_col)) ? a:node : a:row_or_col

        for subtree in a:node[1]
            let result = move_window#find_outermost(a:type, subtree, row_or_col, a:winid)

            if !empty(result)
                return result
            endif
        endfor
    endif
endfunction

function! move_window#find_innermost(type, node, row_or_col, winid) abort
    if a:node[0] ==# 'leaf'
        return a:node[1] == a:winid ? a:row_or_col : []
    else
        let row_or_col = a:node[0] ==# a:type ? a:node : a:row_or_col

        for subtree in a:node[1]
            let result = move_window#find_innermost(a:type, subtree, row_or_col, a:winid)

            if !empty(result)
                return result
            endif
        endfor
    endif
endfunction

function! move_window#move(winid, dir) abort
    if a:dir ==# 'left' || a:dir ==# 'right'
        let col = move_window#find_innermost('col', winlayout(), [], a:winid)
        let source_columns = move_window#column_size(row)
        let neighbour = move_window#find_neighbour(row, a:dir)
        let target_columns = move_window#column_size(neighbour)

        if source_columns > target_columns
            " Fit the current window into the next row
        else 
        endif

        let source_buffer = bufnr()
        close
        call win_gotoid(target_winid)
        execute printf('rightbelow vertical sbuffer %d', source_buffer)

        let leaf_pos = 0
        let neighbour = row[leaf_pos + 1]

        if neighbour[0] ==# 'leaf'
            return
        elseif neighbour ==# 'col'
        else
            echoerr '???'
        endif
    elseif a:dir ==# 'up' || a:dir ==# 'down'
    else
        echoerr printf("vim-move-window: Unknown direction '%s'", a:dir)
endfunction

function! move_window#paste_full(dir) abort
    let dir = a:dir[0]
    let win_ids = []
    let i = 2
    let winnr = winnr('1' . dir)
    call add(win_ids, win_getid(winnr))

    while 1
        let next_winnr = winnr(i . dir)

        if winnr == next_winnr
            break
        endif

        let winnr = next_winnr
        call add(win_ids, win_getid(next_winnr))
        let i += 1
    endwhile

    for win_id in win_ids
        execute printf('%dclose!', win_id2win(win_id))
    endfor

    wincmd j

    for win_id in win_ids
        execute printf('rightbelow vert sbuffer %d', winbufnr(win_id2win(win_id)))
    endfor
endfunction
