

set print address on 
set print static off 
set print static-members off 
set print pretty on 
set print array on 
set print max-symbolic-offset 0 
set print elements 0 
set print null-stop 
set print union on 
set print asm-demangle on 
set print object on 
set print vtbl on 
set history save 
set history size 65535
handle SIGPIPE pass nostop 
handle SIGUSR1 pass nostop print 
handle SIGUSR2 pass nostop print 

set debuginfod enabled on
set backtrace past-main


set height 0
set pagination off

source ~/git/vdb/vdb.py

set vdb-theme any
vdb start

set vdb-memory-ignore-empty-sections on
set vdb-svd-directories {ENVDIR}/svd/
set vdb-svd-auto-scan off
set vdb-svd-scan-background off




alias hd = hexdump
