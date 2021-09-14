"CtrlSF
nmap     <C-s>f <Plug>CtrlSFPrompt
vmap     <C-s>f <Plug>CtrlSFVwordPath
vmap     <C-s>F <Plug>CtrlSFVwordExec
nmap     <C-s><C-f> <Plug>CtrlSFCwordPath
nmap     <C-s>p <Plug>CtrlSFPwordPath
nnoremap <C-s>o :CtrlSFOpen<CR>
nnoremap <C-s>t :CtrlSFToggle<CR>
let g:ctrlsf_auto_focus = {"at": "start"}
let g:ctrlsf_confirm_save = 0
let g:ctrlsf_auto_preview = 1
