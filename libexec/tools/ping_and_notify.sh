#!/usr/bin/env bash

# /****************************************************************************
#  * Monitor target host by ping and notify by voice if status changed.
#  * For macOS only
#  * ORIGIN: 2021-09-04 by hmr
# ****************************************************************************/

#// Arguments
targetHost="${1}"
interval="${2:-"1"}"
maxConsecErr="${3:-"2"}" #// Max count of consecutive error
voiceType="${4:-"ava"}"

#// Announcement
a_disconnected="Host '${targetHost}' disconnected."
a_recovered="Host '${targetHost}' recovered."

#// Check arguments
if [[ -z "${targetHost}" ]]; then
	echo "Error: Target host is required."
	echo
	echo "Usage: $(basename "${0}") <target host> [-4|6] [-i interval] [-c max consecutive errors] [-v voice]"
	echo "       Default interval is 1. Default max consecutive errors is 2."
	exit 1
fi

#/********** Functions **********/
#// make Ctrl-C work certainly
function trapBreak() {
	printf "Break!\n"
	exit
}
trap trapBreak 2

#// Workaround for "Alarm clock: 14"
function alarmClock() {
	#// just ignore
	counter=$(showDots "${counter}" "e")
	return
}
trap alarmClock 14

#// Simply returns date string
function getDate() {
	date +'%Y-%m-%d %H:%M:%S'
}

#// Show progress dots
function showDots() {

	local c str

	case "$#" in
		0) c=0 ;;
		1) c=$1 ;;
		*) c=$1
			str=$2
			;;
	esac

	if (( c % 2 == 0 )); then
		>&2 printf "%s" "${str:-"."}"
	fi
	if (( c > 0 && c % 120 == 0 )); then
		>&2 printf "(%s) [%s]\n" "$(getDate)" "${targetHost}"
	fi

	((c++)) #// Increment counter
	printf '%d' "${c}"
}

function pingUntilError() {
	while ping -W 1500 -t 1 -q "${targetHost}" >& /dev/null
	do
		err=0 #// Reset error counter when ping succeeded
		counter=$(showDots "${counter}")
		#sleep "${interval}"
	done
}

#// Entry point
printf '[%s] Start watching [%s] every %d seconds. Report when consecutive %d errors.\n' "$(getDate)" "${targetHost}" "${interval}" "${maxConsecErr}"

while true
do
	#// Loop until ping fails
	counter=1 #// counter
	err=0     #// error counter
	while [[ "${err}" -le "${maxConsecErr}" ]]
	do
		pingUntilError
		counter=$(showDots "${counter}" "!") #// Show error dot
		((err++)) #// Increment error counter when ping failed
	done

	printf '\n'
	printf '[%s] Response interupted.\n' "$(getDate)"
	# afplay ~/Library/Sounds/mixkit-sci-fi-confirmation-914.wav
	afplay ~/Library/Sounds/Attention/SeatbeltSign_2.m4r
	say -v "${voiceType}" "${a_disconnected}"
	printf '\n'

	#// Loop until ping succeeds
	counter=1
	while ! ping -W 1000 -t 1 -q "${targetHost}" >& /dev/null
	do
		counter=$(showDots ${counter} "!")
		#sleep ${interval}
	done

	printf '\n'
	printf '[%s] Response recovered.' "$(getDate)"
	# afplay ~/Library/Sounds/mixkit-sci-fi-confirmation-914.wav
	afplay ~/Library/Sounds/Attention/SeatbeltSign_1.m4r
	say -v "${voiceType}" "${a_recovered}"
	printf '\n'
done

#// vim: set syn=bash ft=sh ff=unix fileencoding=utf-8 ts=4 sw=4 :
