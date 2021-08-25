function GoToBazelTarget()
  let current_file = expand("%:t")
  let pattern = "\\V\\<" . current_file . "\\>"
  exe "edit" findfile("BUILD", ".;")
  call search(pattern, "w", 0, 500)
endfunction

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

nnoremap <leader>gb :call GoToBazelTarget()<CR>
nnoremap <leader>yb :call YankBazelTarget()<CR>

