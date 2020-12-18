# vim:ft=bash:ts=2:sw=0:et

# GPP::app::zsh
# install.bash

# AUTHOR: hmr
# ORIGIN: 2020-07-14

# GPP installer for zsh settings

# backup old files
# link .zshenv
# link .zlogout
# link .zprofile
# link .zshrc
# link .zshrc_gpp
# link .p10k.zsh

echo "Installing ${GPP_PKG}"

_PREV_DIR=$(pwd)

GPP_PKG=zsh
GPP_PKG_DIR=$(gpg_pkg_dir ${GPP_PKG})
[ -z "${GPG_PKG_DIR}" ] && exit 1

####################
# Link zsh dot files
n "zshenv zlogout zprofile zshrc zshrc_gpp p10k.zsh"
cd ${GPG_PKG_DIR}
for GPP_INST_TARGET in "zshenv zlogout zprofile zshrc zshrc_gpp p10k.zsh"
do
  GPP_INST_TARGET_REAL="~/.${GPP_INST_TARGET}"
  if [ -e ~/.${GPP_INST_TARGET_REAL} ]; then
    mv ${GPP_INST_TARGET_REAL} ${GPP_INST_TARGET_REAL}.${GPP_INST_DATE}
  fi

  ln -s dot-${GPP_INST_TARGET} ${GPP_INST_TARGET_REAL}
done

cd ${_PREV_DIR}
