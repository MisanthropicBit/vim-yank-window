let s:yanked_buffer = -1

function! yank_window#yank() abort
    let s:yanked_buffer = bufnr()
    let winnr = winnr()

    echom printf(
        \'Yanked window winid: %d, winnr:%d, bufnr:%d tabpage:%d',
        \win_getid(winnr),
        \winnr,
        \s:yanked_buffer,
        \tabpagenr()
    \)
endfunction

function! yank_window#yank_and_quit() abort
    if tabpagenr('$') == 1 && winnr('$') == 1
        echom 'Cannot yank and quit current window since it is the only open window'
        return
    endif

    let s:yanked_buffer = bufnr()

    " Close the window into the buffer, not the buffer itself
    close
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

function! yank_window#paste(dir, full_width) abort
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
endfunction
