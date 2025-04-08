
test -s ~/.alias && . ~/.alias || true
test -s ~/.alias.env && . ~/.alias.env || true
export PATH=${HOME}/local/bin/:${HOME}/opt/bin:${HOME}/bin:/usr/local/bin:/usr/local/sbin/:/bin:/sbin/:/usr/bin:/usr/sbin/:/usr/lib/mit/sbin:/opt/cross/bin:${PATH}

shopt -s cdspell
shopt -s dirspell
shopt -s checkhash
shopt -s globstar


HISTCONTROL=ignoreboth
HISTFILE=${HOME}/.bash_history
HISTFILESIZE=100000
HISTSIZE=100000
HISTTIMEFORMAT='%c '

function print_time( )
{
    NUM=$1
    NUMD=${#NUM}

    if [[ $NUMD -gt 9 ]];
    then
	PRE=$((NUMD-9))
	PRED=${NUM:0:${PRE}}
	POST=${NUM:${PRE}:3}
	SUF="s"
    elif [[ $NUMD -gt 6 ]];
    then
	PRED=$NUM
	PRE=$((NUMD-6))
	PRED=${NUM:0:${PRE}}
	POST=${NUM:${PRE}:3}
	SUF="ms"
    elif [[ $NUMD -gt 3 ]];
    then
	PRED=$NUM
	PRE=$((NUMD-3))
	PRED=${NUM:0:${PRE}}
	POST=${NUM:${PRE}:3}
	SUF="µs"
    else
	PRED=$NUM
	POST="0"
	SUF="ns"
    fi
    printf "%s.%s%s" ${PRED} ${POST} ${SUF}
}

function trim_zeroes( )
{
    NUM=$1
    while [[ ${NUM:0:1} == "0" ]];
    do
	NUM=${NUM:1}
    done
    echo $NUM
}

function bark_ps0( )
{
    echo "BARK"
}

function get_time( )
{
    date "+%s.%N"
}

function stats_start( )
{
    if [[ "${PROMPT_COMMAND}" != *"${BASH_COMMAND}"* ]];
    then
	TIMER_START=$(get_time)
    fi
}

function stats_stop( )
{
    if [[ -z "$TIMER_START" ]];
    then
	LAST_POST_RESULT="           "
	return
    fi
#    echo "STOP_PROMPT_COMMAND=$PROMPT_COMMAND"
#    echo "BC=$BC"
#    echo "STOPTIME0"
#    echo "BASHPID=$BASHPID"
#    echo "STATS_STOP"
#    return
#    date +%s.%N
#    echo "STOP"
#    trap 'stats_start' DEBUG
#    return
    TIMER_END=$(get_time)
    TIMER_START_S=${TIMER_START:0:10}
    TIMER_START_NS=${TIMER_START:11:9}
    TIMER_END_S=${TIMER_END:0:10}
    TIMER_END_NS=${TIMER_END:11:9}
#    echo "TIMER_START=$TIMER_START"
#    echo "TIMER_START_S=$TIMER_START_S"
#    echo "TIMER_START_NS=$TIMER_START_NS"
#    echo "TIMER_END=$TIMER_END"
#    echo "TIMER_END_S=$TIMER_END_S"
#    echo "TIMER_END_NS=$TIMER_END_NS"
    TIMER_S=$(($TIMER_END_S-$TIMER_START_S))
#    echo "TIMER_S=$TIMER_S"
    TIMER_END_NS="${TIMER_S}${TIMER_END_NS}"
#    echo "TIMER_END_NS=$TIMER_END_NS"
    TIMER_START_NS=$(trim_zeroes ${TIMER_START_NS})
    TIMER_END_NS=$(trim_zeroes ${TIMER_END_NS})
#    echo "TIMER_START_NS=$TIMER_START_NS"
#    echo "TIMER_END_NS=$TIMER_END_NS"
    TIMER_NS=$(( ${TIMER_END_NS} - ${TIMER_START_NS} ))
#    echo "TIMER_NS=$TIMER_NS"
    C=${BrightBlack:2:10}
    LAST_POST_RESULT=$(printf "${C}%10s " $(print_time $TIMER_NS))
    TIMER_START=""
}

#trap 'stats_start' DEBUG
#PROMPT_COMMAND=stats_stop

GIT_PROMPT_THEME=Single_line_NoExitState_openSUSE
GIT_PROMPT_SHOW_UPSTREAM=
LAST_POST_RESULT="           "
. {ENVDIR}/git/bash-git-prompt/gitprompt.sh
export EDITOR=vim


#. ~/git/fuzzy_bash_completion/fuzzy_bash_completion
#fuzzy_replace_filedir_xspec
#fuzzy_setup_for_command cd
#fuzzy_setup_for_command ls
#fuzzy_setup_for_command l
#fuzzy_setup_for_command ll
#fuzzy_setup_for_command vim &>/dev/null
#fuzzy_setup_for_command vi &>/dev/null
#fuzzy_setup_for_command git


# Setup fzf
# ---------
if [[ ! "$PATH" == *{ENVDIR}/git/fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}{ENVDIR}/git/fzf/bin"
fi

# Auto-completion
# ---------------
source "{ENVDIR}/git/fzf/shell/completion.bash"

# Key bindings
# ------------
source "{ENVDIR}/git/fzf/shell/key-bindings.bash"


export PREVIEWLINES=500

# GIT heart FZF
# -------------

is_in_git_repo() {
  git rev-parse HEAD > /dev/null 2>&1
}

fzf-down() {
  fzf --height 50% "$@" --border
}

gf() {
  is_in_git_repo || return
  git -c color.status=always status --short |
  fzf-down -m --ansi --nth 2..,.. \
    --inline-info --bind page-up:preview-up,page-down:preview-down \
    --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' |
  cut -c4- | sed 's/.* -> //'
}


    #--preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$PREVIEWLINES |
gb() {
  is_in_git_repo || return
  git branch -a --color=always | grep -v '/HEAD\s' | sort |
  fzf-down --ansi --multi --tac --preview-window right:70% \
    --inline-info --bind page-up:preview-up,page-down:preview-down \
    --preview 'git lol $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$PREVIEWLINES |
  sed 's/^..//' | cut -d' ' -f1 |
  sed 's#^remotes/##'
}

gt() {
  is_in_git_repo || return
  git tag --sort -version:refname |
  fzf-down --multi --preview-window right:70% \
    --inline-info --bind page-up:preview-up,page-down:preview-down \
    --preview 'git show --color=always {} | head -'$PREVIEWLINES
}

  #git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always |
gh() {
  is_in_git_repo || return
  git lola |
  fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
    --header 'Press CTRL-S to toggle sort' \
    --inline-info --bind page-up:preview-up,page-down:preview-down \
    --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$PREVIEWLINES |
  grep -o "[a-f0-9]\{7,\}"
}

    #--preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" {1} | head -'$PREVIEWLINES |
gr() {
  is_in_git_repo || return
  git remote -v | awk '{print $1 "\t" $2}' | uniq |
  fzf-down --tac \
    --inline-info --bind page-up:preview-up,page-down:preview-down \
    --preview 'git lol {1} | head -'$PREVIEWLINES |
  cut -d$'\t' -f1
}

case "$-" in
    *i*)
	bind '"\er": redraw-current-line'
	bind '"\C-g\C-f": "$(gf)\e\C-e\er"'
	bind '"\C-g\C-b": "$(gb)\e\C-e\er"'
	bind '"\C-g\C-t": "$(gt)\e\C-e\er"'
	bind '"\C-g\C-h": "$(gh)\e\C-e\er"'
	bind '"\C-g\C-r": "$(gr)\e\C-e\er"'
	bind "set menu-complete-display-prefix on"
	bind "set show-all-if-ambiguous on"
	bind 'TAB':menu-complete
esac

FZF_DEFAULT_OPTS="--inline-info --bind page-up:preview-up,page-down:preview-down --height=60% --preview 'fzf_preview ${PREVIEWLINES} "{}"'"

export GCC_COLORS="error=01;31:warning=01;35:note=01;36:range1=32:range2=94:locus=01:quote=01:fixit-insert=32:fixit-delete=31:diff-filename=01:diff-hunk=32:diff-delete=31:diff-insert=32"


cdr() {
    root=$(git rev-parse --show-toplevel)
    cd "${root}"
}

function iecho()
{
	if [[ $- != *i* ]];
	then
		return
	fi
	echo $@
}

function iprintf()
{
	if [[ $- != *i* ]];
	then
		return
	fi
	printf $@
}



function venv_status()
{
	VDIR="$1"
	NUM_ALL=$(${VDIR}pip list --format freeze | wc -l)
	NUM_EDIT=$(${VDIR}pip list -e --format freeze | wc  -l)
	NUM_LOCL=$(${VDIR}pip list -l --format freeze | wc  -l)
	NUM_USER=$(${VDIR}pip list --user --format freeze | wc  -l)
	iecho "${NUM_ALL} pip packages, ${NUM_EDIT} editable, ${NUM_LOCL} in venv, ${NUM_USER} for current user"
}


function venv()
{
    TENV=$1

    if [[ -z "${TENV}" ]];
    then
		ACTIVE_VENV=$(basename "${VIRTUAL_ENV}")
		# just list
		iecho "Installed virtual environments:"
		for e in ~/.venv/*;
		do
			if [[ -d "${e}" ]];
			then
				VNAME=$(basename ${e})
				VPRE=""
				if [[ "${VNAME}" == "${ACTIVE_VENV}" ]];
				then
					VPRE="*"
				fi
				VER=$(${e}/bin/python3 --version)
				STATUS=$(venv_status "${e}/bin/")
				#echo -e "${VPRE}${VNAME}\t${VER}\t${STATUS}"
				iprintf "%-16s %-16s %s\n" "${VPRE}${VNAME}" "${VER}" "${STATUS}"
			fi
		done
	else
		ACTIVATE=~/".venv/${TENV}/bin/activate"
		if [[ ! -f "${ACTIVATE}" ]];
		then
			iecho "Unknown venv ${TENV}, creating with current python3"
			python3 -m venv --system-site-packages ~/".venv/${TENV}"
			source "${ACTIVATE}"
		else
			source "${ACTIVATE}"
			iecho "Activated environment ${TENV}"
		fi
		if [[ $- == *i* ]];
		then
			python --version
		fi
		venv_status
    fi
}



# vim: tabstop=4 shiftwidth=4 noexpandtab
