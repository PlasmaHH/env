#!/usr/bin/python3

#import ycm_core
import os
import json
import shlex
import copy
import ycm_core

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


log(f"{ccommands=}")
# TODO add automatic reloading after something in VS changed
oldpath = ""
while( oldpath != thispath ):
    log(f"{oldpath=}, {thispath=}")

    for x in [ "Build", "build" ]:
        try:
            log(f"{thispath=}")
            adpath = f"{thispath}/{x}/active_build_dir.txt"
            log(f"{adpath=}")
            with open(adpath) as f:
                active_builddir = f.read()
            log(f"{active_builddir=}")
            active_builddir = win2wsl(active_builddir).strip()
            log(f"{active_builddir=}")
            ccommands = active_builddir + "/compile_commands.json"
            oldpath = thispath
            break
        except FileNotFoundError:
            pass
    else:
        oldpath = thispath
        thispath = os.path.dirname(thispath)

cdir = os.path.dirname(ccommands)
log(f"{ccommands=}")
if( not os.path.isfile(ccommands) ):
    cdb=[]
else:
    with open(ccommands) as cfile:
        cdb = json.load(cfile)

database = ycm_core.CompilationDatabase( os.path.dirname(ccommands) )
log(f"{database=}")


default_iar_flags = [ "--driver-mode=g++", "-Wall", "-Wextra","-std=gnu++2c", "-D__CEL_INCLUDE_INTERNAL__=1", "-D__CEL_HW_UART_H_=1", "--target=arm-none-eabi" ]
default_gcc_flags = [ "g++", "--driver-mode=g++", "-x", "c++", "-Wall", "-Wextra","-std=gnu++2c", "-D__GNU__=1", "-D__CEL_INCLUDE_INTERNAL__=1", "-D__CEL_HW_UART_H_=1" ]

class compile_command:

    def __init__( self, cmd, file ):
        file = win2wsl(file)
        self.file = file
        cmd = win2wsl(cmd)
        cmd = shlex.split(cmd)
        self.flags = []
        self.db_flags = []
        # Take gcc flags verbatim
        if( cmd[0].endswith("gcc") or cmd[0].endswith("g++") ):
            compilation_info = database.GetCompilationInfoForFile( file )
            self.db_flags = compilation_info.compiler_flags_
#            log(f"{self.file=}")
#            log(f"{compilation_info.compiler_flags_=}")
            self.flags = [ compilation_info.compiler_flags_[0] ]
            self.flags += copy.copy(default_gcc_flags)
            self.flags += list(compilation_info.compiler_flags_[1:])
            bcmd = os.path.basename( cmd[0] )
            # gcc/g++ with a prefix
            if( len(bcmd) > 4 ):
                target = bcmd[:-4]
                self.flags.append(f"--target={target}")

        # Translate IAR flags as good as possible
        else:
            if( file.endswith(".c") ):
                self.flags.append( "arm-none-eabi-gcc")
                self.flags.append("-xc")
            else:
                self.flags.append( "arm-none-eabi-g++")
                self.flags.append("-xc++")
            self.flags += copy.copy(default_iar_flags)
            for c in cmd:
                match c:
                    case c if c.startswith("-I"):
                        self.flags.append(c)
                    case c if c.startswith("-D"):
                        self.flags.append(c)
                    case c if c.startswith("-W"):
                        self.flags.append(c)
#                case _:
#                    print("c = '%s'" % (c,) )
#        self.flags.append(f"-c")

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
    if( not file.startswith("/") ):
        cc = compile_command( cmd, cdir + "/" + file )
        ccdb[cc.file] = cc

#log(ccdb)

def Settings( **kwargs ):
    filename = kwargs["filename"]
    cc=ccdb.get(filename,None)
    log("")
    log(f"Settings({kwargs=})")

    # XXX Figure out if we are in a gcc or IAR build case and only in the gcc do this
    if kwargs.get("language") == 'cfamily' and True:
        DIR_OF_THIS_SCRIPT = os.path.abspath( os.path.dirname( __file__ ) )
        cmake_commands = ccommands
#        cmake_commands = os.path.join( DIR_OF_THIS_SCRIPT, 'build', 'compile_commands.json')
#        log(f"{cmake_commands=}")
        if os.path.exists( cmake_commands ):
            log("returning compile database")
            return {
                    'ls': {
                        'compilationDatabasePath': os.path.dirname( cmake_commands )
                        }
                    }

#    log(f"{cc=}")
#    log("filename = '%s'" % (filename,) )
#    compilation_info = database.GetCompilationInfoForFile( filename )
#    log(f"{compilation_info=}")
#    log(f"{compilation_info.compiler_flags_=}")
#    return { "flags" : compilation_info.compiler_flags_ }
    if( cc is not None ): # Compile command foud in DB
#        cc.flags=['/bin/arm-none-eabi-g++',"-mtune=cortex-m33" ]
#        log(f"{cc.flags=}")
        cc.flags = list(cc.db_flags)
#        log(f"{cc.flags=}")
#        log(" ".join(cc.flags))
        log(f"return first cc not none from cache {cc}")
        return { "flags" : cc.flags }

    if( filename.endswith(".h") ): # Check if there is a cppfile with the same name and path
        cppfile = filename[:-2]
        cppfile += ".cpp"
#        log("cppfile = '%s'" % (cppfile,) )
        cc = ccdb.get(cppfile)
        log(f"{cc=}")
        if( cc is not None ):
            log(f"Return for .h from .cpp {cc}")
            return { "flags" : cc.flags }
    # No cpp file found that coresponds to the header...
    if( len(ccdb) == 0 ): # Not a single command known...
        log(f"ccdb empty, return all default {default_gcc_flags}")
        return { "flags" : default_gcc_flags + [ "-xc++" ] } # Use a default version of the flags
    else: # there are some, just take the first and the flags of it, possibly all are the same anyways
        cc = next(iter(ccdb.values()))
        for allc in ccdb.values():
            if( allc.file.endswith(".cpp") or allc.file.endswith(".cxx") ):
                cc = allc
                break
#        log(f"{cc.flags=}")
        log(f"return arbitrary file from database {cc}")
        return { "flags" : cc.flags }

    log("return nothing, no idea what that thing is")
    return {}

#xx=Settings(filename="/home/lbt/git/nextgen/Quellcode/MainController/assert_handling.cpp")
#print("xx = '%s'" % (xx,) )

# vim: tabstop=4 shiftwidth=4 expandtab ft=python
