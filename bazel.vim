function YankBazelTarget()
  let s:saved_rooter_patterns = g:rooter_patterns
  let g:rooter_patterns = ["WORKSPACE"]
  let s:bazel_root = FindRootDirectory()
  let s:current_file_abs_dir = expand("%:p:h")
  let s:name_under_cursor = matchstr(getline('.'), '"\zs[^"]\+\ze"')
  let s:bazel_target_str = "/" . substitute(s:current_file_abs_dir, s:bazel_root, "", "") . ":" . s:name_under_cursor
  let g:rooter_patterns = s:saved_rooter_patterns
  let @+ = s:bazel_target_str
  let @* = s:bazel_target_str
  let @" = s:bazel_target_str
  return s:bazel_target_str
endfunction

let g:bazel_config = get(g:, 'bazel_config', "--config=adp_gcc9 ")
autocmd FileType bzl nnoremap <buffer> gd :call GoToBazelDefinition()<CR>
nnoremap <leader>gb :call GoToBazelTarget()<CR>
nnoremap <leader>yb :call YankBazelTarget()<CR>
nnoremap <Leader>bt  :call RunBazelHere("test " . g:bazel_config)<CR>
nnoremap <Leader>bb  :call RunBazelHere("build " . g:bazel_config)<CR>
nnoremap <Leader>br  :call RunBazelHere("run " . g:bazel_config)<CR>
nnoremap <Leader>bdb :call RunBazelHere("build " . g:bazel_config . " -c dbg " . "-copt='-g'")<CR>
nnoremap <Leader>bdt :lua  DebugThisTest()<CR>
nnoremap <Leader>bl  :call RunBazel()<CR>

