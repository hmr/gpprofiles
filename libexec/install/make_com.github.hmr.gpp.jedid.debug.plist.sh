#!/usr/bin/env bash
# vim: set ft=sh syn=bash ts=4 sw=4 :

TARGET="${HOME:?}/.config/launchd/com.github.hmr.gpp.jedid.debug"

SDIR="$(cd $(dirname $0)/../.. || { echo "Can't find SDIR."; exit; }; pwd)"
pushd "${SDIR}" || { echo "Can't cd to SDIR."; exit; }

sed 	-e "s/__GPP_VERSION__/$(git log -1 --pretty=%H | cut -c 1-7)/" \
       	-e "s|__GPP_HOME__|${SDIR}|" \
        -e "s|__XDG_CONFIG_HOME__|${XDG_CONFIG_HOME:=${HOME:?}/.config}|" \
        "${TARGET}.plist.tmpl" \
	| tee "${TARGET}.plist"

popd

