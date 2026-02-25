#!/usr/bin/env bash
# vim: set ft=sh syn=bash ts=4 sw=4 :

# --- Validation Logic ---

# 1. Ensure exactly 2 arguments are provided.
if [[ $# -ne 2 ]]; then
    echo "Usage: $0 <INPUT_FILE> <OUTPUT_FILE>" >&2
    exit 1
fi

TGT_IN="$1"
TGT_OUT="$2"

# 2. Check if the input file exists.
if [[ ! -f "${TGT_IN}" ]]; then
    echo "Error: Input file '${TGT_IN}' does not exist." >&2
    exit 1
fi

# 3. Prevent overwriting the same file.
# We compare the files using 'test -ef' which checks if they have the same device and inode numbers.
# This handles cases where one is a symlink or a different relative path to the same file.
if [[ "${TGT_IN}" -ef "${TGT_OUT}" ]]; then
    echo "Error: Input and output files are the same. Overwriting is not allowed." >&2
    exit 1
fi

# 4. Check if the output directory is writable.
TGT_OUT_DIR=$(dirname "${TGT_OUT}")
if [[ ! -w "${TGT_OUT_DIR}" ]]; then
    echo "Error: Cannot write to directory '${TGT_OUT_DIR}'." >&2
    exit 1
fi

# --- Main Logic ---

SDIR="$(cd "$(dirname "$0")/../.." || { echo "Can't find SDIR."; exit 1; }; pwd)"
MAILADDR="${USER}@${HOSTNAME-:$HOST}"
command -v getent >/dev/null 2>&1 \
    && REALNAME="$(getent passwd "${USER}" | cut -d: -f 5 | tr -d ",+$")"
GPP_TMP_DIR="/tmp/com.github.hmr.gpp"
[[ -d ${GPP_TMP_DIR} ]] || mkdir -p "${GPP_TMP_DIR}"

[[ -z ${REALNAME} ]] && REALNAME=${MAILADDR}

(
    cd "${SDIR}" || { echo "Can't cd to SDIR."; exit 1; }

    # Substitution logic.
    # Note: Using '|' as a delimiter to safely handle path strings in variables.
    sed -e "s/__GPP_VERSION__/$(git log -1 --pretty=%H 2>/dev/null | cut -c 1-7 || echo "unknown")/" \
        -e "s|__GPP_HOME__|${SDIR}|" \
        -e "s|__XDG_CONFIG_HOME__|${XDG_CONFIG_HOME:=${HOME:?}/.config}|" \
        -e "s/##__USER_NAME__/${REALNAME}/" \
        -e "s/##__USER_MAIL__/${MAILADDR}/" \
        -e "s/__GPP_VERSION__/$(git log -1 --pretty=%H | cut -c 1-7)/" \
       	-e "s|__GPP_HOME__|${SDIR}|" \
        -e "s|__GPP_TMP_DIR__|${GPP_TMP_DIR}|" \
        "${TGT_IN}" \
        > "${TGT_OUT}"
)

if [[ $? -eq 0 ]]; then
    echo "Successfully generated '${TGT_OUT}'."
else
    echo "Error: sed command failed." >&2
    exit 1
fi
