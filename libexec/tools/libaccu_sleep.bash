#!/usr/bin/env bash
# vim: set noet syn=bash ft=sh ff=unix fenc=utf-8 ts=2 sw=0 : # GPP default modeline for bash script

# libaccu_sleep.bash
#   A (somewhat) reliable Bash timer alternative to sleep(1)
#
# Copyright (c) 2026 hmr
# License: GPL3

# Requirements:
#   - Bash 5 or later is recommended.
#   - When EPOCHREALTIME is unavailable, ACCU_SLEEP falls back
#     to plain sleep without accumulated scheduling.
#
# Usage:
#   source ./libaccu_sleep.bash
#   ACCU_SLEEP "1000000"
#
# Optional hook function:
#   function ACCU_SLEEP_ON_KEY() {
#       local key=$1
#       ...
#   }
#
# Optional globals:
#   ACCU_SLEEP_TTY=/dev/tty
#
# Notes:
#   - Accumulated scheduling uses EPOCHREALTIME.
#   - When EPOCHREALTIME is unavailable, a warning is printed
#       when this file is sourced.
#   - To monitor key inputs during timer operation,
#       define a hook function named ACCU_SLEEP_ON_KEY(). 
#     - This function receives the input as its only argument,
#       allowing you to handle key events.
#     - It doesn't drift much because the library factors in
#       the time taken for key inputs (of course, there are limitation).
#   - /dev/tty is used only when ACCU_SLEEP_ON_KEY is defined.
#   - Access to /dev/tty is not guaranteed in all environments

# Standard input source (default: /dev/tty)
ACCU_SLEEP_TTY=${ACCU_SLEEP_TTY:-/dev/tty}

# For internal use
ACCU_SLEEP_NEXT_US=
ACCU_SLEEP_ORIGINAL_STTY=
ACCU_SLEEP_TTY_READY=0
ACCU_SLEEP_HAS_EPOCHREALTIME=1

if [[ -z ${EPOCHREALTIME-} ]]; then
    ACCU_SLEEP_HAS_EPOCHREALTIME=0
    printf 'libaccu_sleep.bash: warning: EPOCHREALTIME is unavailable; falling back to sleep without accumulated scheduling\n' >&2
fi


# Output the current wall-clock time as microseconds since the Unix epoch.
# Arguments: none.
function ACCU_SLEEP_NOW_US() {
    local t sec usec

    if (( ACCU_SLEEP_HAS_EPOCHREALTIME == 0 )); then
        printf 'ACCU_SLEEP_NOW_US: EPOCHREALTIME is unavailable\n' >&2
        return 1
    fi

    t=$EPOCHREALTIME
    sec=${t%.*}
    usec=${t#*.}
    usec=${usec:0:6}

    printf '%s\n' "$((10#$sec * 1000000 + 10#$usec))"
}

# Format a microsecond value as seconds with six fractional digits.
# Arguments: $1 = time interval in microseconds, may be negative.
function ACCU_SLEEP_FORMAT_US() {
    local us=$1
    local sign=""

    if (( us < 0 )); then
        sign="-"
        us=$((-us))
    fi

    printf '%s%d.%06d' "$sign" "$((us / 1000000))" "$((us % 1000000))"
}

# Return success if the optional key-input hook function is defined.
# Arguments: none.
function ACCU_SLEEP_HAS_KEY_HOOK() {
    declare -F ACCU_SLEEP_ON_KEY >/dev/null
}

# Restore the terminal settings saved by ACCU_SLEEP_SETUP_TTY.
# Arguments: none.
function ACCU_SLEEP_RESTORE_TTY() {
    if (( ACCU_SLEEP_TTY_READY != 0 )) && [[ -n ${ACCU_SLEEP_ORIGINAL_STTY-} ]]; then
        stty "$ACCU_SLEEP_ORIGINAL_STTY" < "$ACCU_SLEEP_TTY"
        ACCU_SLEEP_TTY_READY=0
    fi
}

# Prepare ACCU_SLEEP_TTY for immediate single-character input.
# Arguments: none. Returns failure if no key hook or readable TTY exists.
function ACCU_SLEEP_SETUP_TTY() {
    if ! ACCU_SLEEP_HAS_KEY_HOOK; then
        return 1
    fi

    if (( ACCU_SLEEP_TTY_READY != 0 )); then
        return 0
    fi

    if [[ ! -r $ACCU_SLEEP_TTY ]]; then
        return 1
    fi

    ACCU_SLEEP_ORIGINAL_STTY=$(stty -g < "$ACCU_SLEEP_TTY") || return 1

    # Put the terminal into a mode where control keys can be read immediately.
    stty -echo -icanon min 0 time 0 < "$ACCU_SLEEP_TTY" || return 1

    ACCU_SLEEP_TTY_READY=1

    return 0
}

# Wait until the absolute target time, optionally dispatching key input.
# Arguments: $1 = absolute target time in microseconds since the Unix epoch.
function ACCU_SLEEP_WAIT_UNTIL() {
    local target_us=$1
    local now_us
    local remain_us
    local timeout
    local key

    while true; do
        now_us=$(ACCU_SLEEP_NOW_US)
        remain_us=$((target_us - now_us))

        if (( remain_us <= 0 )); then
            return 0
        fi

        timeout=$(ACCU_SLEEP_FORMAT_US "$remain_us")

        if ACCU_SLEEP_SETUP_TTY; then
            if read -r -s -N 1 -t "$timeout" key < "$ACCU_SLEEP_TTY"; then
                ACCU_SLEEP_ON_KEY "$key"

                # Continue waiting until the original target time.
                continue
            fi

            return 0
        fi

        sleep "$timeout"
        return 0
    done
}

# Reset the accumulated target time used by ACCU_SLEEP.
# Arguments: none.
function ACCU_SLEEP_RESET() {
    ACCU_SLEEP_NEXT_US=
}

# Sleep until the next accumulated schedule point.
# Arguments: $1 = interval to add to the schedule, in microseconds.
function ACCU_SLEEP() {
    local interval_us=$1

    if [[ ! $interval_us =~ ^[0-9]+$ ]]; then
        printf 'ACCU_SLEEP: interval must be an integer number of microseconds: %s\n' \
            "$interval_us" >&2
        return 2
    fi

    if (( ACCU_SLEEP_HAS_EPOCHREALTIME == 0 )); then
        sleep "$(ACCU_SLEEP_FORMAT_US "$interval_us")"
        return $?
    fi

    if [[ -z ${ACCU_SLEEP_NEXT_US-} ]]; then
        ACCU_SLEEP_NEXT_US=$(ACCU_SLEEP_NOW_US)
    fi

    ACCU_SLEEP_NEXT_US=$((ACCU_SLEEP_NEXT_US + interval_us))

    ACCU_SLEEP_WAIT_UNTIL "$ACCU_SLEEP_NEXT_US"
}
