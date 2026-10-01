#!/usr/bin/env bash
# vim: set ft=sh syn=bash fenc=utf-8 ff=unix fixeol et sw=2 ts=2 sts=2: #GPP default modeline for shell scripts
# shellcheck shell=bash disable=SC1091,SC3006,SC3010,SC3021,SC3043,SC3037 source=${GPP_HOME}

TARGET=(ansible bash bat byobu cspell dircolors git gpprofiles homebrew htop istats-menu kitty less lsd mozilla readline rust-cargo rust-rustup ripgrep tmux vim zsh ghostty)

SDIR="$(cd $(dirname $0); pwd)"
. ${SDIR}/install_settings_apps_common.sh

