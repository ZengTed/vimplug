call NERDTreeAddKeyMap({
    \ 'key': 'l',
    \ 'callback': 'NERDTreeDoFilter',
    \ 'quickhelpText': 'filer selected type' })

function! NERDTreeDoFilter()
    let snode = g:NERDTreeFileNode.GetSelected()
    let filter = []
    if snode != {}
        let filename = snode.path.str()
        let fpos = strridx(filename, '.')
        if fpos ==# 0
            return 1
        endif
        let ext = strpart(filename, fpos + 1)
        let r = '\.' .ext .'$'
        let g:NERDTreeFilter = add(filter, r)
        call g:refreshNERDTree()
    endif
endfunction


call NERDTreeAddKeyMap({
    \ 'key': 'L',
    \ 'callback': 'NERDTreeUndoFilter',
    \ 'quickhelpText': 'clear the filer' })

function! NERDTreeUndoFilter()
    let g:NERDTreeFilter = []
    call g:refreshNERDTree()
endfunction


