vnoremap <expr> ! (mode() ==# 'V' ? '!' : ':Psh ')

command! -range -nargs=* -complete=command P <line1>,<line2>call partshell#Part(<q-args>)
" Doing `'<,'>P !` supports tab completion in Neovim but not in Vim, so this
" helper command allows shell completion in Vim by using `'<,'>Psh`
command! -range -nargs=+ -complete=shellcmd Psh <line1>,<line2>call partshell#Part('!'.<q-args>)

" Args
command! -nargs=+ -bang -complete=shellcmd Shargs call partshell#EditSh(<bang>0, <q-args>, 'args')

" Grep
command! -nargs=+ -bang -complete=shellcmd Shgrep call partshell#GrepSh(<bang>0, <q-args>, 0)
command! -nargs=+ -bang -complete=shellcmd Shlgrep call partshell#GrepSh(<bang>0, <q-args>, 1)

" Make
command! -nargs=+ -bang -complete=shellcmd Shmake call partshell#MakeSh(<bang>0, <q-args>, 0)
command! -nargs=+ -bang -complete=shellcmd Shlmake call partshell#MakeSh(<bang>0, <q-args>, 1)

" Splits
command! -nargs=+ -bang -complete=shellcmd Shenew call partshell#Sh(<bang>0, <q-args>, 'enew')
command! -nargs=+ -bang -complete=shellcmd Shnew call partshell#Sh(<bang>0, <q-args>, 'new')
command! -nargs=+ -bang -complete=shellcmd Shtabnew call partshell#Sh(<bang>0, <q-args>, 'tabnew')
command! -nargs=+ -bang -complete=shellcmd Shtabedit call partshell#Sh(<bang>0, <q-args>, 'tabnew')
command! -nargs=+ -bang -complete=shellcmd Shvnew call partshell#Sh(<bang>0, <q-args>, 'vnew')
