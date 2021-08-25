"termdebug
packadd termdebug
function! GdbSetup()
	:call TermDebugSendCommand("set confirm off")
	:call TermDebugSendCommand("set print pretty on")
	:call TermDebugSendCommand("set max-value-size unlimited")
endfunction
function! SetupGdb(...)
	:call TermDebugSendCommand("set confirm off")
	:call TermDebugSendCommand("set print pretty on")
	:call TermDebugSendCommand("file ".a:1)
endfunction
function! EvalGdbVar(...)
	:call TermDebugSendCommand("print ".a:1)
endfunction

function! PrintDbg()
	let wordUnderCursor = expand("<cword>")
	:call TermDebugSendCommand("print ".wordUnderCursor)
endfunction

function! EvalGdb()
	let word = expand("<cword>")
	:call TermDebugSendCommand("print ".word)
endfunction

function! VEvalGdb()
	let word = GetVisualSelection()
	:call TermDebugSendCommand("print ".word)
endfunction

function! QuitGdb()
	:call TermDebugSendCommand("set confirm off")
	:call TermDebugSendCommand("quit")
	:call DeleteBuffers('*gdb')
endfunction


let g:terminal_color_4 = '#ff0000'
let g:terminal_color_5 = 'green'

" copy paste cpp include
function! PasteInclude()
	let filename = getreg('i')
	:norm "ip
endfunction

function! CopyAsInclude()
	let file_path = expand('%')
	let include_path = '#include "'.file_path.'"'."\n"
	let @i=include_path
endfunction

function! AdaptFilePath(filepath, pattern, replacement)
    let index = strridx(a:filepath, a:pattern)
    if (index != -1)
        return a:filepath[0:index] . a:replacement
    endif
    return a:filepath
endfunction

function! SwitchSourceHeader()
    let filepath = expand('%:p:h')
    let filename = expand("%:t:r")
    let fileending = expand("%:e")
    if (fileending == "cpp")
        let filetype = ".h"
        let filepath = AdaptFilePath(filepath, "/src", "includes/**")
        let filepath = AdaptFilePath(filepath, "/Sources", "Includes/**")
    endif
    if (fileending == "h")
        let filetype = ".cpp"
        let filepath = AdaptFilePath(filepath, "/includes", "src/**")
        let filepath = AdaptFilePath(filepath, "/Includes", "Sources/**")
    endif
    exe "find " . filepath . "/" . filename . filetype
endfunction

function! AddIncludeImpl(filename)
	echo a:filename
	let include='#include "'.a:filename.'"'."\n"
	:call setreg('i', include)
	:norm "ip
endfunction

function! AddInclude()
	call fzf#run({'sink': function('AddIncludeImpl')})
endfunction

function! GoToError()
	let filename = getreg('+')
	let tokens = split(filename, ":")
    if (len(tokens) > 0)
		:exec 'edit' tokens[0]
    endif
    if (len(tokens) > 1 && matchstr(tokens[1], "[0-9][0-9]*") != "")
		:exec tokens[1]
    endif
    if (len(tokens) > 2 &&matchstr(tokens[1], "[0-9][0-9]*") != "")
		:exec 'norm' tokens[2]|
    endif
endfunction

" cpp highlight config
let g:cpp_member_variable_highlight = 1
let g:cpp_class_scope_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1
let c_no_curly_error=1

autocmd FileType cpp,c nnoremap <leader>ge :call GoToError()<CR>
autocmd FileType cpp,c nnoremap <leader>ai :call AddInclude()<CR>
autocmd FileType cpp,c nnoremap <leader>th :call SwitchSourceHeader()<CR>
autocmd FileType cpp,c nnoremap <leader>ci :call CopyAsInclude()<CR>
autocmd FileType cpp,c nnoremap <leader>pi :call PasteInclude()<CR>
autocmd FileType cpp,c nnoremap <silent> ev :call EvalGdb()<CR>
autocmd FileType cpp,c vnoremap <silent> ev :call VEvalGdb()<CR>
autocmd FileType cpp,c nnoremap <F3> :Termdebug %:r<CR>G<c-w>jG<c-w>j<c-w>L :vertical resize +40<CR>
autocmd FileType cpp,c nnoremap <F4> :call QuitGdb()<CR>
autocmd FileType cpp,c nnoremap <F5> :Continue<CR>
autocmd FileType cpp,c nnoremap <F6> :Run<CR>
autocmd FileType cpp,c nnoremap <F10> :Over<CR>
autocmd FileType cpp,c nnoremap <F11> :Step<CR>
autocmd FileType cpp,c nnoremap <F8> :Stop<CR>
autocmd FileType cpp,c nnoremap <Del> :Clear<CR>
autocmd FileType cpp,c nnoremap <Insert> :Break<CR>
autocmd FileType cpp,c nnoremap <kInsert> :Break<CR>
autocmd FileType cpp,c nnoremap <silent> so :Over<CR>
autocmd FileType cpp,c nnoremap <silent> si :Step<CR>
autocmd FileType cpp,c nnoremap <silent> co :Continue<CR>
