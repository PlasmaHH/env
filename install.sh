#!/bin/bash

for i in diffs/*.diff;
do
	patch -p1 --dry-run < $i
#    patch -p1 < $i
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


ENVDIR="$(pwd)"


function install()
{
	SRC="$1"
	DST="$2"
#    echo "SRC=$SRC"
#    echo "DST=$DST"
	cp -v "${SRC}" "${DST}"
	sed -i "${DST}" -e "s|{ENVDIR}|${ENVDIR}|g"
}

function insert( )
{
	FILE="$1"
	LINE="$2"

#    echo "FILE=$FILE"
#    echo "LINE=$LINE"
	if grep -q "^${LINE}$" "${FILE}" 2>/dev/null;
	then
		echo "${LINE} already in ${FILE}"
	else
		echo "${LINE} >> ${FILE}"
		echo "${LINE}" >> ${FILE}
	fi
}

install .gdbinit ~/.gdbinit.env
install .bashrc ~/.bashrc.env

insert ~/.gdbinit "source ~/.gdbinit.env"


cd .vim/bundle/YouCompleteMe/
#./install.sh --all --clangd-completer

cd ~/
ln -sf "${ENVDIR}/.vimrc" .
ln -sf "${ENVDIR}/.vim" .

cd ~/bin/
ln -sf ${ENVDIR}/bin/* .
# vim: tabstop=4 shiftwidth=4 noexpandtab
