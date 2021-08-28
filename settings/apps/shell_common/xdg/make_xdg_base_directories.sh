#!/bin/sh

# Part of GPP

# Make XDG Base Directory
# ORIGIN: 2021i-08-28 by hmr

# XDG_CONFIG_HOME
if [ -z "${XDG_CONFIG_HOME}" ]; then
  export XDG_CONFIG_HOME=$HOME/.config
fi

if [ -d "${XDG_CONFIG_HOME}" ]; then
  echo "XDG_CONFIG_HOME exists. skip"
else
  echo "Making XDG_CONFIG_HOME[${XDG_CONFIG_HOME}]"
  mkdir "${XDG_CONFIG_HOME}"
fi

# XDG_CACHE_HOME
if [ -z "${XDG_CACHE_HOME}" ]; then
  export XDG_CACHE_HOME=$HOME/.cache
fi

if [ -d "${XDG_CACHE_HOME}" ]; then
  echo "XDG_CACHE_HOME exists. skip"
else
  echo "Making XDG_CACHE_HOME[${XDG_CACHE_HOME}]"
  mkdir "${XDG_CACHE_HOME}"
fi

# XDG_DATA_HOME
if [ -z "${XDG_DATA_HOME}" ] ; then
  export XDG_DATA_HOME=$HOME/.local/share
fi

if [ -d "${XDG_DATA_HOME}" ]; then
  echo "XDG_DATA_HOME exists. skip"
else
  echo "Making XDG_DATA_HOME[${XDG_DATA_HOME}]"
  mkdir "${XDG_DATA_HOME}"
fi

# XDG_STATE_HOME
if [ -z "${XDG_STATE_HOME}" ]; then
  export XDG_STATE_HOME=$HOME/.local/state
fi

if [ -d "${XDG_STATE_HOME}" ]; then
  echo "XDG_STATE_HOME exists. skip"
else
  echo "Making XDG_STATE_HOME[${XDG_STATE_HOME}]"
  mkdir "${XDG_STATE_HOME}"
fi

# XDG_RUNTIME_DIR
if [ -z "${XDG_RUNTIME_DIR}" ]; then
  export XDG_RUNTIME_DIR=$HOME/.run
fi

if [ -d "${XDG_RUNTIME_DIR}" ]; then
  echo "XDG_RUNTIME_DIR exists. skip"
else
  echo "Making XDG_RUNTIME_DIR[${XDG_RUNTIME_DIR}]"
  mkdir "${XDG_RUNTIME_DIR}"
  chmod 700 "${XDG_RUNTIME_DIR}"
fi

# vim: ft=sh ts=2 sw=2 et ff=unix fenc=utf-8
