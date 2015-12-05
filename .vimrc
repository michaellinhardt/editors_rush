set smartindent
" set cursorcolumn
" set cursorline
set nocompatible " bug arrow
set number
set cc=80
set backspace=2 " backspace work properly
set whichwrap+=<,>,[,] " arrow left right change line

match ErrorMsg '\s\+$'
match ErrorMsg '  \+'

inoremap( ()<left>
inoremap{ {<cr>}<ESC>O
