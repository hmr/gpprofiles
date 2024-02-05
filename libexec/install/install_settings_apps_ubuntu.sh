#!/usr/bin/env bash
# vim: set ft=sh syn=bash ts=4 sw=4 :

TARGET=(alsa ansible bash bat byobu cspell dircolors git gpprofiles htop less lsd  mozilla quilt readline ripgrep tmux vim zsh)

SDIR="$(cd $(dirname $0); pwd)"
. ${SDIR}/install_settings_apps_common.sh

