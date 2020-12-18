#!/bin/bash
# vim: ft=bash:ts=2:sw=0:et

# Library for GPProfile install script
# ORIGIN: 2018/10/11 by hmr

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

get_pkg_dir () {
  [ $# = 0 ] && exit 1
  local _PKG=${1}
  local _DIR=${GPP_SRC_DIR}/settings/apps/${_PKG}
  [ ! -d "${_DIR}" ] && exit 2
  echo ${_DIR}
}

symlink_by_array () {
  cd ${GPG_PKG_DIR}
  for GPP_INST_TARGET in "zshenv zlogout zprofile zshrc zshrc_gpp p10k.zsh"
  do
    GPP_INST_TARGET_REAL="~/.${GPP_INST_TARGET}"
    if [ -e ~/.${GPP_INST_TARGET_REAL} ]; then
      mv ${GPP_INST_TARGET_REAL} ${GPP_INST_TARGET_REAL}.${GPP_INST_DATE}
    fi

    ln -s dot-${GPP_INST_TARGET} ${GPP_INST_TARGET_REAL}
  done
}

# Check kind of shell(bash or zsh)
# Arguments: None
# Returns: [string]shell type(bash or zsh)
function chkshell_internal () {

  # PID of myself
  local _PID=$$;

  # PID of Parant
  local _PPID=$(ps -o ppid -p $_PID | tail -n 1);

  # Use PID instead of PPID
  if ps -p $_PID | grep -qs bash ; then
    echo "bash"
  elif ps -p $_PID | grep -qs zsh ; then
    echo "zsh"
  fi
}

# Delete, backup and install target file
# Arg 1: (str) Original file name
# Arg 2: (str) Link-To file name
# Returns: [int]status code.
function del_bu_inst () {
  [ $# < 2 ] && return 1

  local TARGET=$1
  local REALNAME=$2

  if [ -e ${TARGET} ]; then
    if [ -L ${TARGET} ]; then
      # Delete Symlink
      echo "  Deleting symbolic link ${TARGET}"
      rm -f ${TARGET}
    else
      # Move to backup
      echo "  Backing up ${TARGET} as ${TARGET}.${DATE}"
      mv ${TARGET} ${TARGET}.${DATE}
    fi
  fi

  ln -s dot-${TARGET} ${REALNAME}
}
