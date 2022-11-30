" markdown concealed filetype file
au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} set filetype=markdown_c
au BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn}.{des3,des,bf,bfa,aes,idea,cast,rc2,rc4,rc5,desx} set filetype=markdown_c

" python concealed filetype file
au BufRead,BufNewFile *.{py} set filetype=py_c

" fortran concealed filetype file
au BufRead, BufNewFile *.{f90, t} set filetype=fortran_c 




