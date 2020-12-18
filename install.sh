#!/bin/bash
# vim: ft=bash:ts=2:sw=0:et

# GPProfile install script
# #ORIGIN: 2018/10/11 by hmr

# Load libraries
if [ -r lib/install_lib.bash ]; then
  source lib/install_lib.bash
else
  echo "Can't load libraries. Please move to repository root dir."
  exit 127
fi

# Set basic variables.
GPP_SRC_DIR=`abs_dirname "$0"`
DATE=`date +'%Y%M%d_%H%M%S'`
GIT_HASH=`get_git_hash`

if [ -z "${GPP_SRC_DIR}" -o -z "${DATE}" -o -z "${GIT_HASH}" ]; then
  echo "Can't determine required variables."
  exit 126
fi

# Packages to install
SRCS=".inputrc .vim .vimrc .bashrc_history .bashrc_alias .byobu .bash_profile_ssh-agent .bashrc_env .bashrc_etc .gitconfig .bash_logout"
DEL_SRCS=".bashrc_ssh-agent"

# ======================================================================
# Install process
# ======================================================================
echo
echo "===== Start ====="
echo "GPP_SRC_DIR: ${GPP_SRC_DIR}"
echo "VERSION: ${GIT_HASH}"
echo

# Generating install information.
echo "Generating install information file(.gpprofile)"
echo "# DON'T EDIT: This is GPProfiles' install information." > ~/.gpprofile
echo "GPP_VERSION=${GIT_HASH}" >> ~/.gpprofile
echo "GPP_HOME=${GPP_SRC_DIR}" >> ~/.gpprofile

# generate byobu config files
cat "${GPP_SRC_DIR}/dot-byobu/datetime.tmux.tmpl" > "${GPP_SRC_DIR}/dot-byobu/datetime.tmux"
cat "${GPP_SRC_DIR}/dot-byobu/status.tmpl" > "${GPP_SRC_DIR}/dot-byobu/status"
cat "${GPP_SRC_DIR}/dot-byobu/statusrc.tmpl" > "${GPP_SRC_DIR}/dot-byobu/statusrc"

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
  ln -sf ${GPP_SRC_DIR}/${TARGETSRC} ${TARGET}
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

echo "===== Finished ====="

