#!/usr/bin/env bash
# vim: set ft=sh syn=bash ts=4 sw=4 :

TARGET=(ansible bash bat byobu cspell dircolors git gpprofiles homebrew htop istats-menu kitty less lsd  mozilla readline ripgrep tmux vim zsh)

SDIR="$(cd $(dirname $0); pwd)"
. ${SDIR}/install_settings_apps_common.sh

