setlocal conceallevel=0
setlocal expandtab
setlocal linebreak
setlocal nobreakindent
setlocal nocursorcolumn
setlocal nocursorline
setlocal nomodeline
setlocal scrolloff=12
setlocal shiftwidth=2
setlocal spell
setlocal tabstop=2
setlocal wrap

let b:ale_linters = ['markdownlint', 'vale']
let b:ale_fixers = ['prettier']
