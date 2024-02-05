#!/usr/bin/env bash
# vim: set ft=sh syn=bash ts=4 sw=4 :

SDIR="$(cd $(dirname $0)/../..; pwd)"
pushd "${SDIR}"

sed 	-e "s/__GPP_VERSION__/$(git log -1 --pretty=%H | cut -c 1-7)/" \
       	-e "s|__GPP_HOME__|${SDIR}|" \
        ${HOME:?}/.config/gpprofiles/gpprofiles.tmpl \
	| tee ${HOME:?}/.config/gpprofiles/gpprofiles

popd

