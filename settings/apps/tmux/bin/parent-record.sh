#!/bin/sh
# vim: set ft=sh syn=zsh fenc=utf-8 ff=unix fixeol et sw=4 ts=4 sts=4: #GPP default modeline for shell scripts

# Called from after-split-window. $1 = ID of the newly created child pane
child="$1"
[ -n "$child" ] || exit 0
# When the hook fires, the parent (previously active pane) is "{last}"
parent=$(tmux display-message -p -t '{last}' '#{pane_id}') || exit 0
tmux set-option -p -t "$child" @parent_pane "$parent"
tmux set-option -g "@parent_of_$child" "$parent"
