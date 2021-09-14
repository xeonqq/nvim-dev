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
nnoremap <S-f> :call RipgrepFzf(expand("<cword>"), 1)<CR>
vmap <S-f> :call VisualRG()<CR>
nnoremap <tab> :Buffers<cr>

command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --colors path:fg:cyan --smart-case ".<q-args>, 1, fzf#vim#with_preview(), <bang>0)
command! -bang -nargs=? -complete=dir Buffers
    \ call fzf#vim#buffers(<q-args>, {'options': ['--info=inline']}, <bang>0)

let $FZF_DEFAULT_COMMAND='fd --type file'
let $FZF_DEFAULT_OPTS = '--bind ctrl-space:toggle'
