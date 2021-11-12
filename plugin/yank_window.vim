if &compatible || exists('g:yank_window#loaded')
    finish
endif

let s:cpo_save = &cpoptions
let s:yank_window_version = '0.1.0'

" Return the current version
function! YankWindowVersion() abort
    return s:yank_window_version
endfunction

let g:yank_window#enable_mappings = get(g:, 'yank_window#enable_mappings', 1)

nnoremap <silent> <Plug>(YankWindow)           :<c-u>call yank_window#yank()<cr>
nnoremap <silent> <Plug>(YankWindowAndQuit)    :<c-u>call yank_window#yank_and_quit()<cr>
nnoremap <silent> <Plug>(PasteWindowLeft)      :<c-u>call yank_window#paste('left', 0)<cr>
nnoremap <silent> <Plug>(PasteWindowDown)      :<c-u>call yank_window#paste('down', 0)<cr>
nnoremap <silent> <Plug>(PasteWindowUp)        :<c-u>call yank_window#paste('up', 0)<cr>
nnoremap <silent> <Plug>(PasteWindowRight)     :<c-u>call yank_window#paste('right', 0)<cr>
nnoremap <silent> <Plug>(PasteWindowTabAfter)  :<c-u>call yank_window#paste('tab-after', 0)<cr>
nnoremap <silent> <Plug>(PasteWindowTabBefore) :<c-u>call yank_window#paste('tab-before', 0)<cr>

if g:yank_window#enable_mappings
    nmap <silent> <c-w>yy <Plug>(YankWindow)
    nmap <silent> <c-w>yq <Plug>(YankWindowAndQuit)
    nmap <silent> <c-w>yh <Plug>(PasteWindowLeft)
    nmap <silent> <c-w>yj <Plug>(PasteWindowDown)
    nmap <silent> <c-w>yk <Plug>(PasteWindowUp)
    nmap <silent> <c-w>yl <Plug>(PasteWindowRight)
    nmap <silent> <c-w>yt <Plug>(PasteWindowTabAfter)
    nmap <silent> <c-w>yT <Plug>(PasteWindowTabBefore)
endif

let g:yank_window#loaded = 1
let &cpoptions = s:cpo_save
