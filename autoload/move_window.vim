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
