#!/usr/bin/python3

#import ycm_core
import os
import json
import shlex

def log( s ):
    with open("log","a+",encoding="utf-8") as l:
        l.write(str(s) + "\n")

#log("START")

def win2wsl( p ):
    p=p.replace("W:","/home/lbt")
    p=p.replace("\\\\","/")
    p=p.replace("\\","/")
    return p

#thispath = os.path.dirname(os.path.abspath(__file__))
thispath = os.getcwd()
ccommands = thispath + "/compile_commands.json"

# TODO add automatic reloading after something in VS changed
oldpath = ""
while( oldpath != thispath ):
    try:
#        log(f"{thispath=}")
        with open(thispath + "/Build/active_build_dir.txt") as f:
            active_builddir = f.read()
#        log(f"{active_builddir=}")
        active_builddir = win2wsl(active_builddir).strip()
#        log(f"{active_builddir=}")
        ccommands = active_builddir + "/compile_commands.json"
        break
    except FileNotFoundError:
        oldpath = thispath
        thispath = os.path.dirname(thispath)

#log(f"{ccommands=}")
if( not os.path.isfile(ccommands) ):
    cdb=[]
else:
    with open(ccommands) as cfile:
        cdb = json.load(cfile)

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

ccdb = {}

for x in cdb:
#    print("x = '%s'" % (x,) )
    try:
        cmd = x["command"]
    except KeyError:
        cmd = " ".join(x["arguments"])
    file= x["file"]
    cc = compile_command( cmd, file )
    ccdb[cc.file] = cc

#log(ccdb)

def Settings( **kwargs ):
    filename = kwargs["filename"]
    cc=ccdb.get(filename,None)
#    log("filename = '%s'" % (filename,) )
    if( cc is not None ):
#        log(" ".join(cc.flags))
#        log(str(cc))
        return { "flags" : cc.flags }
    elif( filename.endswith(".h") ):
        cppfile = filename[:-2]
        cppfile += ".cpp"
#        log("cppfile = '%s'" % (cppfile,) )
        cc = ccdb.get(cppfile)
        if( cc is not None ):
            return { "flags" : cc.flags }
        elif( len(ccdb) == 0 ):
            return { "flags" : compile_command("","").flags }
        else:
            cc = next(iter(ccdb.values()))
            return { "flags" : cc.flags }

    return {}

#xx=Settings(filename="/home/lbt/git/nextgen/Quellcode/MainController/assert_handling.cpp")
#print("xx = '%s'" % (xx,) )

# vim: tabstop=4 shiftwidth=4 expandtab ft=python
