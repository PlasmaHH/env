#!/bin/bash

ENVDIR="$(pwd)"

for i in diffs/*.diff;
do
	patch -f -N -p1 --dry-run < $i &> /dev/null
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
append ~/.gitignore "doc/tags"

cd ~/
ln -sf "${ENVDIR}/.vimrc" .
ln -sf "${ENVDIR}/.vim" .

pushd .
cd "${ENVDIR}/.vim/bundle"
for d in */doc;
do
	echo "Generating vim helptags for $d"
	/usr/bin/vim -X -u NORC "+helptags $d | q "
done
popd

cd ~/bin/
ln -sf ${ENVDIR}/bin/* .
ln -sf ${ENVDIR}/git/git-foresta/git-foresta .

# TODO
# ~/.vim cannot be overwritten when directory
# ~/.gitignore gives an error when not there already
# Before doing enything check prerequisites:
# - go (min 1.23?)
# - python devel (min 3.11?)
# - make
# - cmake
# Check for the mistake of having submodules not cloned recursively and do it automagically
#
# Unknown errors yet: 
# - fatal: ref HEAD is not a symbolic ref (from make bin/fzf)
# Features:
# - collect result of everything and output in a table which went fine and which failed?
# vim: tabstop=4 shiftwidth=4 noexpandtab
