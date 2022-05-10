"FZF
if executable("ag") 
    set grepprg=ag 
endif

set rtp+=$FZF_HOME
autocmd! FileType fzf tnoremap <buffer> <leader>q <c-p>
nnoremap <silent> <expr> <C-f> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"

function! VisualRG()
	:let selection=GetVisualSelection()
	:call RipgrepFzf(selection, 1) 
endfunction

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --colors path:fg:cyan %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

function! RgNoReloadFzf(query, fullscreen)
    let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s'
    let initial_command = printf(command_fmt, shellescape(a:query))
    call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(), a:fullscreen)
endfunction

"insert path
function! Paste(value)
	:call setreg('p', a:value)
	:norm "ppa
endfunction

function! InsertPath()
	call fzf#run({'sink': function('Paste')})
endfunction
imap <C-F> <ESC>:call InsertPath()<CR>

function! ExtractText(key, value)
	return a:value['text']
endfunction

function! PasteYankStack()
	let s:yankstack = map(g:Yankstack(), function('ExtractText'))
	call fzf#run(fzf#wrap({'source': s:yankstack, 'sink': function('Paste')}))
endfunction

imap <C-p> <ESC>:call PasteYankStack()<CR>
nnoremap <C-p> :call PasteYankStack()<CR>
nnoremap <S-f> :call RgNoReloadFzf(expand("<cword>"), 1)<CR>
vmap <S-f> :call VisualRG()<CR>
nnoremap <tab> :Buffers<cr>
nnoremap <leader>s :call RipgrepFzf("", 1)<CR>
nnoremap <leader>f :call RipgrepFzf(getreg("+"), 1)<CR>
" Path completion with custom source command
" inoremap <expr> <c-x><c-f> fzf#vim#complete#path('fd')

" Word completion with custom spec with popup layout option
"inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'window': { 'width': 0.2, 'height': 0.9, 'xoffset': 1 }})

command! -bang -nargs=+ -complete=dir Rag call fzf#vim#ag_raw(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

command! -bang -nargs=? -complete=dir Buffers
    \ call fzf#vim#buffers(<q-args>, {'options': ['--info=inline']}, <bang>0)

let $FZF_DEFAULT_COMMAND='fd --type file'
let $FZF_DEFAULT_OPTS = '--bind ctrl-space:toggle'
