" python concealed filetype file
" au BufRead,BufNewFile *.{py} set filetype=py_c

" fortran concealed filetype file
" au BufRead, BufNewFile *.{f90,t} set filetype=fortran_c 
" au BufRead, BufNewFile, BufReadPost *.t set filetype=fortran 
" au BufRead, BufNewFile, BufReadPost *.t set syntax=fortran

au BufNewFile,BufRead *.t setfiletype fortran_c

