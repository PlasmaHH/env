#!/bin/bash

for i in diffs/*.diff;
do
	patch -p1 --dry-run < $i
done
# vim: tabstop=4 shiftwidth=4 noexpandtab
