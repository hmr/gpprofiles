#!/usr/bin/env bash
# vim: set noet syn=bash ft=sh ff=unix fenc=utf-8 ts=2 sw=0 : # GPP default modeline for bash script
# shellcheck shell=bash disable=SC1091,SC2155,SC3010,SC3021,SC3037 source=${GPP_HOME}
#
# Jedid
# Detects macOS auto appearance change and set some CLI applications' color setting

# Part of GPP

# AUTHOR: hmr
# ORIGIN: 2024-03-29


function check_sidechange() {

	if defaults read -g AppleInterfaceStyle 2>&1 | grep -qi "dark" >& /dev/null; then
		if [[ ${MODE} != "dark" ]]; then
			# Light -> Dark
			echo "1"
			return
		fi
	else
		if [[ ${MODE} != "light" ]]; then
			# Dark -> Light
			echo "2"
			return
		fi
	fi
	echo "0"
	return
}


# echo "Starting jedid..." > /dev/stderr
# echo "Initial MODE=${MODE}" > /dev/stderr
while true; do
	# echo "MODE=${MODE}" > /dev/stderr

	WHICH_SIDE=""
	WHICH_SIDE="$(check_sidechange)"
	# Changed to Dark
	if (( WHICH_SIDE==1 )); then
		# echo "Sidechanged: Light->Dark" > /dev/stderr

		## lsd
		CONFIG_DIR="${XDG_CONFIG_HOME}/lsd"
		if [[ -d ${CONFIG_DIR} ]] && cd "${CONFIG_DIR}"; then
			ln -sf themes/default.yaml colors.yaml
		fi

		## bat
		CONFIG_DIR="${XDG_CONFIG_HOME}/bat"
		if [[ -d ${CONFIG_DIR} ]]  && cd "${CONFIG_DIR}"; then
			ln -sf condig-dark config
		fi

		# set mode
		MODE="dark"

	# Changed to Light
elif (( WHICH_SIDE==2 )); then
		# echo "Sidechanged: Dark->Light" > /dev/stderr

		## lsd
		CONFIG_DIR="${XDG_CONFIG_HOME}/lsd"
		if [[ -d ${CONFIG_DIR} ]] && cd "${CONFIG_DIR}"; then
			ln -sf themes/default-light.yaml colors.yaml
		fi

		## bat
		CONFIG_DIR="${XDG_CONFIG_HOME}/bat"
		if [[ -d ${CONFIG_DIR} ]] && cd "${CONFIG_DIR}"; then
			ln -sf condig-light config
		fi

		# set mode
		MODE="light"
	fi

	# stop working
	sleep 15
done

