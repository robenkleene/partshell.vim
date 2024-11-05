command! -nargs=+ -complete=shellcmd Shedit call partshell#ArgsSh(<q-args>)
command! -nargs=+ -bang -complete=shellcmd Shgrep call partshell#GrepSh(<bang>0, <q-args>)
command! -nargs=+ -bang -complete=shellcmd Shmake call partshell#MakeSh(<bang>0, <q-args>)

command! -range -nargs=* -complete=command P silent <line1>,<line2>call partshell#Part(<q-args>)

command! -nargs=+ -bang -complete=shellcmd Shenew call partshell#Sh(<bang>0, <q-args>, 'enew')
command! -nargs=+ -bang -complete=shellcmd Shnew call partshell#Sh(<bang>0, <q-args>, 'new')
command! -nargs=+ -bang -complete=shellcmd Shtabnew call partshell#Sh(<bang>0, <q-args>, 'tabnew')
command! -nargs=+ -bang -complete=shellcmd Shvnew call partshell#Sh(<bang>0, <q-args>, 'vnew')
