

"if exists("b:current_syntax")
"  finish
"endif

unlet b:current_syntax
runtime! syntax/markdown.vim
unlet b:current_syntax
syntax include @markdown syntax/markdown.vim

syn match GitCommitText '.*' contains=@markdown
syn match GitCommitComment '^#.*' contains=Comment

hi link GitCommitComment Comment
