" Vim syntax file
" Language:	C

syn match	cNumbers	display transparent "\<\d\|\.\d" contains=cNumber,cFloat,cOctalError,cOctal,cFloatTime,cNumberTime,cNumberComplex
syn match	cNumber		display contained "\('\|\d\)\+\(u\=l\{0,2}\|ll\=u\)\>"
syn match	cNumberTime     display contained "\('\|\d\)\+\(h\|min\|s\|ns\|ms\|us\)\>"
syn match	cNumberTime     display contained "\('\|\d\)\+\.\('\|\d\)\+\(h\|min\|s\|ns\|ms\|us\)\>"
syn match	cNumberComplex  display contained "\('\|\d\)\+\(il\|if\|i\)\>"
syn match	cNumber		display contained "0x\('\|\x\)\+\(u\=l\{0,2}\|ll\=u\)\>"
syn match	cNumber		display contained "0\(b\|B\)\(0\|1\)\+\(u\=l\{0,2}\|ll\=u\)\>"
syn match	cFloatTime	display contained "\d\+\.\d*\(e[-+]\=\d\+\)\=[fl]\=\(h\|min\|s\|ns\|ms\|us\)\>"

syn match	cFloat		display contained "\d\+\.\d*\(e[-+]\=\d\+\)\=[fl]\=\>"
hi def link cNumberTime		NumberTime
hi def link cFloatTime		NumberTime
hi def link cNumberComplex      NumberComplex
hi def link cCppOutIf2		cCppOut2  " Old syntax group for #if 0 body
hi def link cCppOut2		cCppOut  " Old syntax group for #if of #if 0

syn clear cErrInBracket
syn match	cErrInBracket	display contained "[){}]\|<%\|%>"

" vim: ts=8
