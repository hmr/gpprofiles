#!/usr/bin/env bash
# vim: set noet syn=bash ft=sh ff=unix fenc=utf-8 ts=2 sw=0 : # GPP default modeline for bash script
# shellcheck shell=bash disable=SC1091,SC3006,SC3010,SC3021,SC3043,SC3037 source=${GPP_HOME}

# Part of GPP

# dot-shell_rc_env_secret

# Copy or make symbolic link of each settings


# Install settings
TARGET=(alsa ansible bash bat byobu cspell dircolors git gsed gpprofiles htop less lsd  mozilla quilt readline ripgrep rust-cargo rust-rustup systemd-user tmux vim zsh)

SDIR="$(cd $(dirname $0); pwd)"
. ${SDIR}/install_settings_apps_common.sh

# Settings that require special treatment
# Systemd


