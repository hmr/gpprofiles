#!/bin/bash

# GPProfile install script
# #ORIGIN: 2018/10/11 by hmr
# vim: ft=bash:ts=2:sw=0:et

function get_git_hash() {
  local gitHash=$(git rev-parse --short HEAD)
  if [ $? -ne 0 ]; then
    echo error
    return 1
  else
    echo ${gitHash}
  fi
}

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

function del_from_bashrc () {
  if [ -z "$1" ]; then
    echo "del_from_bashrc(): Not enough args"
    return
  fi
  grep "$1" ~/.bashrc >& /dev/null
  if [ $? -eq 0 ]; then
    echo "    Uninstalling $1"
    sed -i -e "/$1/d" ~/.bashrc
  else
    echo "    $1 is already uninstalled."
  fi
}

function add_into_bashrc () {
  if [ -z "$1" ]; then
    echo "add_into_bashrc(): Not enough args"
    return
  fi
  grep "$1" ~/.bashrc >& /dev/null
  if [ $? -ne 0 ]; then
    echo "    Installing $1"
    echo "source ~/.$1   #$1[gpprofile]" >> ~/.bashrc
  else
    echo "    $1 is already installed."
  fi
}

function add_call_bashrc_into_bash_profile () {
  grep ".bashrc" ~/.bash_profile >& /dev/null
  if [ $? -ne 0 ]; then
    echo "    Adding bashrc call routine into bash_profile."
    echo "[ -r ~/.bashrc ] && . ~/.bashrc #call bashrc[gpprofile]" >> ~/.bash_profile
  else
    echo "    bashrc call routine is already installed."
  fi
}

function add_into_bash_profile () {
  if [ -z "$1" ]; then
    echo "add_into_bash_profile(): Not enough args"
    return
  fi
  grep "$1" ~/.bash_profile >& /dev/null
  if [ $? -ne 0 ]; then
    echo "    Installing $1"
    echo "source ~/.$1   #$1[gpprofile]" >> ~/.bash_profile
  else
    echo "    $1 is already installed."
  fi
}

function add_into_bashrc_before_specified_line () {
  if [ -z "$2" ]; then
    echo "add_into_bashrc_before_specified_line(): Not enough arg(s)"
    return
  fi
  grep "$2" ~/.bashrc >& /dev/null && echo "    GPProfile signboard is alreasy installed." && return

  echo "    Adding GPProfiles signboard."
  sed -i ~/.bashrc -e "/$1/i $2"
}


SRCDIR=`abs_dirname "$0"`
DATE=`date +'%Y%M%d_%H%M%S'`
SRCS=".inputrc .vim .vimrc .bashrc_history .bashrc_alias .byobu .bash_profile_ssh-agent .bashrc_env .bashrc_etc .gitconfig .bash_logout"
DEL_SRCS=".bashrc_ssh-agent"
GIT_HASH=`get_git_hash`

echo
echo "===== Start ====="
echo "SRCDIR: ${SRCDIR}"
echo "VERSION: ${GIT_HASH}"
echo

# generate dot-gitconfig file into SRCDIR
cat ${SRCDIR}/dot-gitconfig.tmpl | sed -e "s/#name = .*/name = `whoami`@`hostname -s`/" -e "s/#email = .*/email = `whoami`@`hostname`/" > dot-gitconfig

# generate byobu config files
cat "${SRCDIR}/dot-byobu/datetime.tmux.tmpl" > "${SRCDIR}/dot-byobu/datetime.tmux"
cat "${SRCDIR}/dot-byobu/status.tmpl" > "${SRCDIR}/dot-byobu/status"
cat "${SRCDIR}/dot-byobu/statusrc.tmpl" > "${SRCDIR}/dot-byobu/statusrc"

cd ~

##### Delete config file which isn't used now.
for TARGET in ${DEL_SRCS}
do
    TARGETSRC=`echo ${TARGET} | sed -e 's/^\./dot-/'`
  echo Deleting ${TARGET}
  cd ~
  if [ -L ${TARGET} ]; then
    echo "    Deleting symbolic link ${TARGET}"
    rm ${TARGET}
  else
    echo "    ${TARGET} doesn't exist."
  fi
done
echo

###### Make symbolic links with backing up
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

#####
echo Adding to bashrc
add_into_bashrc_before_specified_line 'source ~\/.bashrc_history' '[ -f ~/.gpprofile ] && echo -n "GPProfile found. " && cat ~/.gpprofile #show signboard[gpprofile]'
add_into_bashrc bashrc_history
add_into_bashrc bashrc_alias
add_into_bashrc bashrc_env
add_into_bashrc bashrc_etc

grep '#byobu-prompt#' .bashrc >& /dev/null
if [ $? -ne 0 ]; then
  echo "    Installing byobu-prompt"
  echo "[ -r ~/.byobu/prompt ] && . ~/.byobu/prompt   #byobu-prompt[gpprofile]#" >> .bashrc
else
  echo "    byobu-prompt is already installed."
fi
echo

#####
echo Deleting from bashrc
del_from_bashrc bashrc_ssh-agent
echo

#####
echo Adding to bash_profile
# bashrc callup routine.
grep ".bashrc" ~/.bash_profile >& /dev/null
if [ $? -ne 0 ]; then
  echo "    Installing bashrc call routine."
  echo "[ -r ~/.bashrc ] && . ~/.bashrc #call bashrc[gpprofile]" >> ~/.bash_profile
else
  echo "    bashrc call routine is already installed."
fi
add_call_bashrc_into_bash_profile
add_into_bash_profile bash_profile_ssh-agent
echo

echo "VERSION: ${GIT_HASH}" > ~/.gpprofile

echo "===== Finished ====="

