" Disable arrow keys so that I'll stop using them.
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

syntax on

" Some commands.
"yy p 					Yank current line, copy and paste
":m-2 , :m+2				Swap lines
"0					Beginning of liine
"$					End of line
"r5					Replace cursor with 5 & stay in vim mode
"G					Go to end of file
"o					Begin a new line below the cursor and insert text
"O					Begin a new line above the cursor and insert text
"~					Toggle case of the character under the cursor, or all visually-selected characters
"x					Delete current character
"u					Undo last change
"i					Insert mode
"a					Insert mode after cursor

" vimdiff
"]c					next conflict
"[c					previous conflict
