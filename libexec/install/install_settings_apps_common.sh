#!/usr/bin/env bash
# vim: set noet syn=bash ft=sh ff=unix fenc=utf-8 ts=2 sw=0 : # GPP default modeline for bash script
# shellcheck shell=bash disable=SC1091,SC3006,SC3010,SC3021,SC3043,SC3037 source=${GPP_HOME}

# Part of GPP

# install_settings_apps_common.sh


# Install the settings in the argument
if [[ -z $TARGET ]]; then
	echo "Error: Env TARGET isn't set."
	exit 1
fi

SDIR="$(cd $(dirname $0)/../..; pwd)"
echo "SDIR=$SDIR"

export GPP_HOME="${GPP_HOME:=${SDIR:?}}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:=${HOME:?}/.config}"
export XDG_DATA_HOME="${XDG_DATA_HOME:=${HOME:?}/.local/share}"

echo "TARGET: ${TARGET[*]}"
echo "GPP_HOME: $GPP_HOME"
echo "XDG_CONFIG_HOME: $XDG_CONFIG_HOME"
echo "XDG_DATA_HOME: $XDG_DATA_HOME"
echo

for APP in "${TARGET[@]:?}"; do
	echo "Installing ${APP:?}"

	# Settings that require special treatment
	if [[ ${APP} = "systemd-user" ]]; then
		TMP_BASE_DIR="${XDG_CONFIG_HOME}/systemd"
		[[ -d ${TMP_BASE_DIR} ]] \
			&& mv "${TMP_BASE_DIR}" "${TMP_BASE_DIR}.orig"
		mkdir -p "${TMP_BASE_DIR}"

		TMP_APP_DIR="${TMP_BASE_DIR}/user"
		ln -s "${GPP_HOME}/settings/os/ubuntu/systemd/user" "${TMP_APP_DIR}"

	elif [[ ${APP} = "rust-cargo" ]]; then
		TMP_BASE_DIR="${XDG_DATA_HOME}/cargo"
		[[ -d ${TMP_BASE_DIR} ]] \
			&& mv "${TMP_BASE_DIR}" "${TMP_BASE_DIR}.orig"
		mkdir -p "${TMP_BASE_DIR}"

	elif [[ ${APP} = "rust-rustup" ]]; then
		TMP_BASE_DIR="${XDG_DATA_HOME}/rustup"
		[[ -d ${TMP_BASE_DIR} ]] \
			&& mv "${TMP_BASE_DIR}" "${TMP_BASE_DIR}.orig"
		mkdir -p "${TMP_BASE_DIR}"

	elif [[ ${APP} = "gsed" ]]; then
		TMP_BASE_DIR="${HOME}/.local/bin"
		[[ -d ${TMP_BASE_DIR} ]] \
			|| mkdir -p "${TMP_BASE_DIR}"
		ln -s "$(which sed)" "${TMP_BASE_DIR}/gsed"

	# Generic processesing
	else
		# Rename old settings if present
		#TODO: make a better logic...(in case the directory to rename is already exists)
		if [[ -d ${XDG_CONFIG_HOME:?}/${APP} ]]; then
			echo "  Moving old config as ${APP}.orig"
			mv "${XDG_CONFIG_HOME}/${APP}" "${XDG_CONFIG_HOME}/${APP}.orig"
		fi

		# Some settings need additional processing
		if [[ ${APP} = "vim" ]]; then
			ln -s "${GPP_HOME}/settings/apps/vim/dot-vim" "${XDG_CONFIG_HOME}/vim"
		else
			ln -s "${GPP_HOME}/settings/apps/${APP}" "${XDG_CONFIG_HOME}"
		fi
	fi
done

