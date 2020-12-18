# vim:ft=bash:ts=2:sw=0:et

# GPP::app::bash
# install.bash

# AUTHOR: hmr
# ORIGIN: 2020-07-01

# GPP installer for bash settings

# link .bash_logout -> dot-bash_logout
# link .bash_profile_gpp_ssh-agent -> dot-bash_profile_gpp_ssh-agent
# link .bashrc_gpp -> dot-bashrc_gpp
# modify .bashrc
# modify .bash_profile

_PREV_DIR=$(pwd)

GPP_PKG=zsh
GPP_PKG_DIR=${GPP_SRC_DIR}/settings/apps/${GPP_PKG}

echo "Installing ${GPP_PKG}"

if [ ! -d "$GPP_PKG_DIR}" ]; then
  echo "  GPG_PKG_DIR(${GPG_PKG_DIR}) not found."
  exit 1
fi

GPP_PKG_DIR_SUB=${GPP_SRC_DIR}/settings/apps/shell_common
if [ ! -d "$GPP_PKG_DIR_SUB}" ]; then
  echo "  GPG_PKG_DIR_SUB(${GPG_PKG_DIR_SUB}) not found."
  exit 1
fi

cd ${GPG_PKG_DIR}

####################

