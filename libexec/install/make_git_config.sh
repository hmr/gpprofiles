#!/usr/bin/env bash
# vim: set ft=sh syn=bash ts=4 sw=0 :

SDIR="$(cd $(dirname $0)/../..; pwd)"

TMPL="${HOME:?}/.config/git/dot-gitconfig.tmpl"
OUTPUT="${HOME:?}/.config/git/config"

REALNAME="$(getent passwd ${USER} | cut -d: -f 5 | tr -d ",+$")"
MAILADDR="${USER}@${HOSTNAME-:$HOST}"


if [[ ! -r ${TMPL} ]]; then
    echo "Template ${TMPL} not found."
    exit
fi
if [[ ! -d $(dirname ${OUTPUT}) ]]; then
    echo "Output directory $(dirname ${OUTPUT}) not exist."
    exit
fi

sed -e "s/##__USER_NAME__/${REALNAME}/" \
    -e "s/##__USER_MAIL__/${MAILADDR}/" \
    "${TMPL}" \
| tee "${OUTPUT}"

