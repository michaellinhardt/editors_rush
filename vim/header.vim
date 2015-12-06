
let s:asciiart = [
			\"                            ",
			\"        :::      ::::::::   ",
			\"      :+:      :+:    :+:   ",
			\"    +:+ +:+         +:+     ",
			\"  +#+  +:+       +#+        ",
			\"+#+#+#+#+#+   +#+           ",
			\"     #+#    #+#             ",
			\"    ###   ######## fr       ",
			\"                            "]

let s:filled = "/* ".repeat('*', 80 - 6)." */"
let s:logol = strlen(s:asciiart[0])

function! Verify()
	if getline(8) =~ "Created: "
		return 1
	else
		return 0
	endif
endfunction

function! EmptyWLogo(i)
	let l:logoindex = a:i
	let l:line = "/*".repeat(' ', 80 - s:logol - 4).s:asciiart[logoindex]."*/"
	return l:line
endfunction

function! Draw()
	call append(0, '')
	call append(0, s:filled)
	let i = 8
	while i >= 0
		call append(0, EmptyWLogo(i))
		let i = i-1
	endwhile
	call append(0, s:filled)
endfunction

function! SetVars()
	execute("normal 6G5lR"."By: ".$USER.' <'.$MAIL.'>')
	execute("normal 8G5lR"."Created: ".strftime("%Y/%m/%d %H:%M:%S")." by ".$USER)
	call Update()
	execute("normal 12G")
endfunction

function! Create()
	let l:header = Verify()
	if !header
		call Draw()
		call SetVars()
	else
		echo "Header already here"
	endif
endfunction

function! Update()
	let l:header = Verify()
	if l:header && &mod
		execute("normal 4G5lR".expand("%"))
		execute("normal 9G5lR"."Updated: ".strftime("%Y/%m/%d %H:%M:%S")." by ".$USER)
	else
		echo "No changes"
	endif
endfunction

command! Header call Create()
noremap <c-c><c-h> call Header ()
autocmd BufWritePre * call Update()
