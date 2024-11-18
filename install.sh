#!/bin/bash

ENVDIR="$(pwd)"

for i in diffs/*.diff;
do
	patch -f -p1 --dry-run < $i &> /dev/null
	if [[ $? == 0 ]];
	then
		patch -p1 < $i
	fi
#    patch -R -p1 < $i
done


for cmd in bat gdb vim git git ctags;
do
	x=$(which $cmd 2>/dev/null)
	if [[ -z "$x" ]];
	then
		echo "Need to install ${cmd}"
	fi
done

# Build a few different things
cd "${ENVDIR}/git/fzf"
make bin/fzf
cd "${ENVDIR}/.vim/bundle/YouCompleteMe/"
./install.py --all --clangd-completer
cd "${ENVDIR}"

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

function append( )
{
	FILE="$1"
	shift
	ENTRY="$@"
	cp "${FILE}" "${FILE}.tmp"
	echo "${ENTRY}" >> "${FILE}.tmp"
	sort -u "${FILE}.tmp" > "${FILE}"
}

cd "${ENVDIR}"

install .gdbinit ~/.gdbinit.env
install .bashrc ~/.bashrc.env
install .alias ~/.alias.env
install .tmux.conf ~/.tmux.env.conf
install .tmux.vim.conf ~/.tmux.vim.conf

insert ~/.gdbinit "source ~/.gdbinit.env"
insert ~/.bashrc "source ~/.bashrc.env"
insert ~/.tmux.conf "source ~/.tmux.env.conf"

git config --global --add include.path ${ENVDIR}/.gitconfig
append ~/.gitignore ".*.swp"

cd ~/
ln -sf "${ENVDIR}/.vimrc" .
ln -sf "${ENVDIR}/.vim" .

cd ~/bin/
ln -sf ${ENVDIR}/bin/* .
# vim: tabstop=4 shiftwidth=4 noexpandtab
