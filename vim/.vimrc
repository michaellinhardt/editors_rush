set nocompatible " bug arrow do ABCD
set backspace=2 " backspace work correctly
syntax on
set number
set cc=80

" cursor info on bottom right
set ruler

" indentation
filetype plugin indent on
set smartindent
set tabstop=4
set shiftwidth=4

match ErrorMsg '\s$'
2match ErrorMsg '  \+'

inoremap( ()<left>
inoremap{ {<cr>}<ESC>O

" save *.swp / backup files in ~/.vim/{swapfiles,backupdir}
set backupdir=~/.vim/backupfiles
set directory=~/.vim/swapfiles
