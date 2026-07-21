#!/bin/sh
# vim: set ft=sh syn=zsh fenc=utf-8 ff=unix fixeol et sw=4 ts=4 sts=4: #GPP default modeline for shell scripts

# Wrapper for prefix+x. $1 = ID of the pane about to be closed (still alive)
dead="$1"
[ -n "$dead" ] || exit 0
parent=$(tmux display-message -p -t "$dead" '#{@parent_pane}' 2>/dev/null)
if [ -n "$parent" ] && tmux display-message -p -t "$parent" '' >/dev/null 2>&1; then
  tmux select-pane -t "$parent"
fi
tmux kill-pane -t "$dead"
tmux set-option -gu "@parent_of_$dead" 2>/dev/null
exit 0
