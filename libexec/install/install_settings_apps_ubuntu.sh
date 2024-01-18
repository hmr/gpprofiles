#!/usr/bin/env bash
# vim: set ft=sh syn=bash ts=4 sw=4 :

TARGET=(alsa ansible bash bat byobu cspell dircolors git htop less lsd  mozilla quilt readline ripgrep tmux vim zsh)

export GPP_HOME="${GPP_HOME:=${HOME:?}/src/gpprofiles}"
export XDG_CONFIG_HOME="${XDG_CONFIG_HOME:=${HOME:?}/.config}"

for APP in "${TARGET[@]:?}"
do
    echo "Installing ${APP:?}"
    #TODO: make a better logic...
    if [[ -d ${XDG_CONFIG_HOME:?}/${APP} ]]; then
        echo "  Moving old config as ${APP}.orig"
	mv "${XDG_CONFIG_HOME}/${APP}" "${XDG_CONFIG_HOME}/${APP}.orig"
    fi

    # Some apps need special treatment
    if [[ ${APP} = "vim" ]]; then
	ln -s "${GPP_HOME}/settings/apps/vim/dot-vim" "${XDG_CONFIG_HOME}/vim"
    else
	ln -s "${GPP_HOME}/settings/apps/${APP}" "${XDG_CONFIG_HOME}"
    fi
done

