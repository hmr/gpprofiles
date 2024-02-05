#!/bin/bash

# Part of GPP

# make_xbgbd_for_vim.sh
# ORIGIN: 2021-08-28 by hmr

function chk_and_mkdir() {
    local TARGET_DIR
    TARGET_DIR=$1
    [ -z "${TARGET_DIR}" ] && return

    if [ -d "${TARGET_DIR}" ]; then
        echo "Found ${TARGET_DIR}"
    else
        echo "Making ${TARGET_DIR}"
        mkdir -p "${TARGET_DIR}"
    fi
}

if [ -z "${XDG_DATA_HOME}" ] ; then
  export XDG_DATA_HOME="${HOME:?}/.local/share"
fi

chk_and_mkdir "${XDG_DATA_HOME:?}/vim/undo"
chk_and_mkdir "${XDG_DATA_HOME:?}/vim/swap"
chk_and_mkdir "${XDG_DATA_HOME:?}/vim/backup"
chk_and_mkdir "${XDG_DATA_HOME:?}/vim/view"
chk_and_mkdir "${XDG_CONFIG_HOME:?}/vim/after"

# vim: ft=sh syn=bash ts=2 sw=2 et fenc=utf-8 ff=unix
