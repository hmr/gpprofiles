#!/usr/bin/env bash
# vim: set noet syn=bash ft=sh ff=unix fenc=utf-8 ts=2 sw=0 : # GPP default modeline for bash script
# shellcheck shell=bash disable=SC1091,SC3006,SC3010,SC3021,SC3043,SC3037 source=${GPP_HOME}

TARGET=(ansible bash bat byobu cspell dircolors git gpprofiles homebrew htop istats-menu kitty less lsd mozilla readline rust-cargo rust-rustup ripgrep tmux vim zsh ghostty)

SDIR="$(cd $(dirname $0); pwd)"
. ${SDIR}/install_settings_apps_common.sh

