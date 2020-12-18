# vim:ft=bash:ts=2:sw=0:et

# GPP::app::git
# install.bash

# AUTHOR: hmr
# ORIGIN: 2020-07-10

_PREV_DIR=$(pwd)

GPP_PKG=git
GPP_PKG_DIR=${GPP_SRC_DIR}/settings/apps/${GPP_PKG}

echo "Installing ${GPP_PKG}"

if [ ! -d "$GPP_PKG_DIR}" ]; then
  echo "  GPG_PKG_DIR(${GPG_PKG_DIR}) not found."
  exit 1
fi

cd ${GPG_PKG_DIR}

# generate dot-gitconfig file into GPP_SRC_DIR
cat dot-gitconfig.tmpl \
  | sed -e "s/#name = .*/name = `whoami`@`hostname -s`/" \
        -e "s/#email = .*/email = `whoami`@`hostname`/" \
  > dot-gitconfig

if [ -e ~/.gitconfig ]; then
  mv ~/.gitconfig ~/.gitconfig.${GPP_INST_DATE}
fi

ln -s dot-gitconfig ~/.gitconfig

cd ${_PREV_DIR}

####################

