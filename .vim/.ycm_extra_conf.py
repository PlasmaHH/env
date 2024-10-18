#!/usr/bin/python3

#import ycm_core
import os
import json
import shlex

def log( s ):
    with open("log","a+",encoding="utf-8") as l:
        l.write(str(s) + "\n")

#def print(x):
#    log(x)

def win2wsl( p ):
    p=p.replace("W:","/home/lbt")
    p=p.replace("\\\\","/")
    p=p.replace("\\","/")
    return p

thispath = os.path.dirname(os.path.abspath(__file__))
ccommands = thispath + "/compile_commands.json"

# TODO add automatic reloading after something in VS changed

if( not os.path.isfile(ccommands) ):
    try:
        with open(thispath + "/Build/active_build_dir.txt") as f:
            active_builddir = f.read()
        active_builddir = win2wsl(active_builddir).strip()
        ccommands = active_builddir + "/compile_commands.json"
    except FileNotFoundError:
        pass

#log(f"{ccommands=}")
if( not os.path.isfile(ccommands) ):
    cdb=[]
else:
    cfile = open(ccommands)
    cdb = json.load(cfile)
    cfile.close()


class compile_command:

    def __init__( self, cmd, file ):
        file = win2wsl(file)
        self.file = file
        cmd = win2wsl(cmd)
        cmd = shlex.split(cmd)
        self.flags=[ "-Wall", "-Wextra","-std=gnu++2c" ]
        for c in cmd:
            match c:
                case c if c.startswith("-I"):
                    self.flags.append(c)
                case c if c.startswith("-D"):
                    self.flags.append(c)
#                case _:
#                    print("c = '%s'" % (c,) )
        if( file.endswith(".c") ):
            self.flags.append("-xc")
        else:
            self.flags.append("-xc++")

iardb = {}

for x in cdb:
#    print("x = '%s'" % (x,) )
    cmd = x["command"]
    file= x["file"]
    iar = compile_command( cmd, file )
    iardb[iar.file] = iar

log(iardb)

def Settings( **kwargs ):
    filename = kwargs["filename"]
    iar=iardb.get(filename,None)
#    log("filename = '%s'" % (filename,) )
    if( iar is not None ):
#        log(" ".join(iar.flags))
#        log(str(iar))
        return { "flags" : iar.flags }
    elif( filename.endswith(".h") ):
        cppfile = filename[:-2]
        cppfile += ".cpp"
#        log("cppfile = '%s'" % (cppfile,) )
        iar = iardb.get(cppfile)
        if( iar is not None ):
            return { "flags" : iar.flags }
        elif( len(iardb) == 0 ):
            return { "flags" : compile_command("","").flags }
        else:
            iar = next(iter(iardb.values()))
            return { "flags" : iar.flags }

    return {}

#xx=Settings(filename="/home/lbt/git/nextgen/Quellcode/MainController/assert_handling.cpp")
#print("xx = '%s'" % (xx,) )

# vim: tabstop=4 shiftwidth=4 expandtab ft=python
