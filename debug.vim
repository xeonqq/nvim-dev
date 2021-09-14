" treesitter {{{
lua <<EOF
require "nvim-treesitter.configs".setup {
  ensure_installed = "maintained",
  highlight = { enable = true },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    swap = {
      enable = true,
      swap_next     = { ["<leader>sa"] = "@parameter.inner", },
      swap_previous = { ["<leader>sA"] = "@parameter.inner", },
    },
  },
  playground = { enable = true }
}
EOF
" }}}



fun! GotoWindow(id)
    call win_gotoid(a:id)
    MaximizerToggle
endfun

lua << EOF
local function write_to_file(filename, lines)
  vim.cmd('e ' .. filename)
  vim.cmd('%delete')
  for _,line in pairs(lines) do
    vim.cmd("call append(line('$'), '" .. line .. "')")
  end
  vim.cmd('1d')
  vim.cmd('w')
  vim.cmd('e#')
end

function _G.create_cpp_vimspector_json_for_bazel_test()
    local test_filter = require('bazel').get_gtest_filter()
    local executable =  require('bazel').get_bazel_test_executable()
    local lines = {
        '{',
        '  "configurations": {',
        '    "GTest": {',
        '      "adapter": "vscode-cpptools",',
        '      "configuration": {',
        '        "request": "launch",',
        '        "program": "' .. executable .. '",',
        '        "args": ["--gtest_filter=\'\'' .. test_filter .. '\'\'"],',
        '        "stopOnEntry": false',
        '      }',
        '    }',
        '  }',
        '}'}
    write_to_file('.vimspector.json', lines)
end

function _G.DebugThisTest()
    create_cpp_vimspector_json_for_bazel_test()
    vim.cmd('new')
    vim.cmd('call termopen("bazel build " . g:bazel_config . " -c dbg " . g:current_bazel_target, {"on_exit": "StartVimspector"})')
end
EOF

function! StartVimspector(job_id, code, event) dict
    if a:code == 0
        close
        call vimspector#Launch()
    endif
endfun

function! OpenErrorInQuickfix()
    cexpr []
    caddexpr getline(0,'$')
    copen
    let l:qf_list = []
    for entry in getqflist()
        if (entry.valid == 1) 
            if (entry.bufnr !=0)
                call add(l:qf_list, entry)
            else
                call FindUnitTest(split(entry.text, '\.')[-1])
                for test in getqflist()
                    call add(l:qf_list, test)
                endfor
            endif
        endif
    endfor
    call setqflist(l:qf_list)
endfunction

function! FindUnitTest(test_name)
    exe "Ack! -G '\.cpp' " . a:test_name . " application/adp"
endfunction

function! AdaptFilePath(filepath, pattern, replacement)
    let index = strridx(a:filepath, a:pattern) 
    if (index != -1)
        return a:filepath[0:index] . a:replacement
    endif
    return a:filepath
endfunction

" Debugger remaps
nnoremap <leader>m :MaximizerToggle!<CR>
nnoremap <leader>dd :call vimspector#Launch()<CR>
nnoremap <leader>dc :call GotoWindow(g:vimspector_session_windows.code)<CR>
nnoremap <leader>dt :call GotoWindow(g:vimspector_session_windows.tagpage)<CR>
nnoremap <leader>dv :call GotoWindow(g:vimspector_session_windows.variables)<CR>
nnoremap <leader>dw :call GotoWindow(g:vimspector_session_windows.watches)<CR>
nnoremap <leader>ds :call GotoWindow(g:vimspector_session_windows.stack_trace)<CR>
" nnoremap <leader>do :call GotoWindow(g:vimspector_session_windows.output)<CR>
nnoremap <leader>de :call vimspector#Reset()<CR>

nnoremap <leader>dtcb :call vimspector#CleanLineBreakpoint()<CR>

nmap <leader>l <Plug>VimspectorStepInto
nmap <leader>j <Plug>VimspectorStepOver
nmap <leader>k <Plug>VimspectorStepOut
nmap <leader>dr <Plug>VimspectorRestart
nnoremap <leader>d<space> :call vimspector#Continue()<CR>

nmap <leader>rc <Plug>VimspectorRunToCursor
nmap <leader>bp <Plug>VimspectorToggleBreakpoint
nmap <leader>dbp :call vimspector#ClearBreakpoints()<CR>
nmap <leader>cbp <Plug>VimspectorToggleConditionalBreakpoint
