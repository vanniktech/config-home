" Disable arrow keys so that I'll stop using them.
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

syntax on

" Some commands.
"yy         Copy current line
"P          Paste above
"p          Paste below

":m-2 :m+2	Swap lines
"r					Replace cursor with next input & stay in vim mode

"gg					Go to beginning of file
"G					Go to end of file

"o					Begin a new line below the cursor and insert text
"O					Begin a new line above the cursor and insert text

"~					Toggle case of the character under the cursor, or all visually-selected characters
"x					Delete current character

"u					Undo last change
"^r         Redo last change

"V					Visual mode
"i					Insert mode
"a					Insert mode after cursor

"zz         Center cursor

"{          Move cursor to previous code block
"}          Move cursor to next code block

"0					Beginning of line
"$					End of line
"^          Move cursor to first word
"w          Move cursor to next word
"W          Move cursor to next word ignoring dots
"b          Move cursor to previous word
"B          Move cursor to previous word ignoring dots
"t!         Move cursor in beginning of !
"f!         Move cursor on !
"%          Move cursor to matching bracket
"tD;        Move cursor to second instance of D

"cw         Change word
"C          Delete everything on the line after the cursor

"*          Find usages

" Combos
"d}         Delete entire block
"d$, D      Delete until end of line
"15dd       Delete 15 lines
"ct}        Delete everything on the line until }

" vimdiff
"]c					next conflict
"[c					previous conflict