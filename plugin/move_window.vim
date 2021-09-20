if &compatible || exists('g:move_window#loaded')
    finish
endif

let s:cpo_save = &cpoptions
let s:move_window_version = '0.1.0'

" Return the current version
function! MoveWindowVersion() abort
    return s:move_window_version
endfunction

let g:move_window#enable_mappings = get(g:, 'move_window#enable_mappings', 1)

nnoremap <silent> <Plug>(YankWindow)           :<c-u>call move_window#yank(0)<cr>
nnoremap <silent> <Plug>(YankWindowAndQuit)    :<c-u>call move_window#yank(1)<cr>
nnoremap <silent> <Plug>(PasteWindowLeft)      :<c-u>call move_window#paste('left', 0)<cr>
nnoremap <silent> <Plug>(PasteWindowDown)      :<c-u>call move_window#paste('down', 0)<cr>
nnoremap <silent> <Plug>(PasteWindowUp)        :<c-u>call move_window#paste('up', 0)<cr>
nnoremap <silent> <Plug>(PasteWindowRight)     :<c-u>call move_window#paste('right', 0)<cr>
nnoremap <silent> <Plug>(PasteWindowTabAfter)  :<c-u>call move_window#paste('tab-after', 0)<cr>
nnoremap <silent> <Plug>(PasteWindowTabBefore) :<c-u>call move_window#paste('tab-before', 0)<cr>

if g:move_window#enable_mappings
    nmap <silent> <c-w>yy <Plug>(YankWindow)
    nmap <silent> <c-w>yq <Plug>(YankWindowAndQuit)
    nmap <silent> <c-w>yh <Plug>(PasteWindowLeft)
    nmap <silent> <c-w>yj <Plug>(PasteWindowDown)
    nmap <silent> <c-w>yk <Plug>(PasteWindowUp)
    nmap <silent> <c-w>yl <Plug>(PasteWindowRight)
    nmap <silent> <c-w>yt <Plug>(PasteWindowTabAfter)
    nmap <silent> <c-w>yT <Plug>(PasteWindowTabBefore)
endif

let g:move_window#loaded = 1
let &cpoptions = s:cpo_save
