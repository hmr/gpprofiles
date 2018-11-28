#!/bin/bash

abs_dirname() {
  local cwd="$(pwd)"
  local path="$1"

  while [ -n "$path" ]; do
    cd "${path%/*}"
    local name="${path##*/}"
    path="$(readlink "$name" || true)"
  done

  pwd -P
  cd "$cwd"
}

function add_into_bashrc () {
	if [ -z "$1" ]; then
		echo "add_into_bashrc(): Not enough args"
		return
	fi
	grep "$1" ~/.bashrc >& /dev/null
	if [ $? -ne 0 ]; then
		echo "    Installing $1"
		echo "source ~/.$1   #$1" >> ~/.bashrc
	else
		echo "    $1 is already installed."
	fi
}

SRCDIR=`abs_dirname "$0"`

SRCS=".inputrc .vim .vimrc .bashrc_history .bashrc_alias .byobu .bashrc_ssh-agent .bashrc_env .gitconfig"
DATE=`date +'%Y%M%d_%H%M%S'`

echo "SRCDIR: ${SRCDIR}"

# generate dot-gitconfig file
cat ${SRCDIR}/dot-gitconfig.tmpl | sed -e "s/name = .*/name = `whoami`@`hostname -s`/" -e "s/email = .*/email =  `whoami`@`hostname`/" > dot-gitconfig

# Make symbolic link with backup
cd ~
for TARGET in ${SRCS}
do
    TARGETSRC=`echo ${TARGET} | sed -e 's/^\./dot-/'`
	echo Installing ${TARGET} from ${TARGETSRC}
	cd ~
	if [ -e ${TARGET} ]; then
		if [ -L ${TARGET} ]; then
			# Delete Symlink
			echo "    Deleting symbolic link ${TARGET}"
			rm -f ${TARGET}
		else
			# Move to backup
			echo "    Backing up ${TARGET} as ${TARGET}.${DATE}"
			mv ${TARGET} ${TARGET}.${DATE}
		fi
	fi
	# Make symlink
	echo "    Making symbolic link"
	ln -sf ${SRCDIR}/${TARGETSRC} ${TARGET}
	echo
done

echo Adding to bashrc
add_into_bashrc bashrc_history
add_into_bashrc bashrc_alias
add_into_bashrc bashrc_env
add_into_bashrc bashrc_ssh-agent

grep '#byobu-prompt#' .bashrc >& /dev/null
if [ $? -ne 0 ]; then
	echo "    Installing byobu-prompt"
	echo "[ -r ~/.byobu/prompt ] && . ~/.byobu/prompt   #byobu-prompt#" >> .bashrc
else
	echo "    byobu-prompt is already installed."
fi

