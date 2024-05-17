#!/bin/bash

for i in diffs/*.diff;
do
	patch -p1 --dry-run < $i
done

# TODO
# vim:
# 	- build ycm

for cmd in bat gdb vim git git ctags;
do
	x=$(which $cmd 2>/dev/null)
	if [[ -z "$x" ]];
	then
		echo "Need to install ${cmd}"
	fi
done
# vim: tabstop=4 shiftwidth=4 noexpandtab
