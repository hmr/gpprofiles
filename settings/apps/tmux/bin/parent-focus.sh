#!/bin/sh
# vim: set ft=sh syn=zsh fenc=utf-8 ff=unix fixeol et sw=4 ts=4 sts=4: #GPP default modeline for shell scripts

# Called from pane-exited. $1 = ID of the closed pane (already destroyed)
dead="$1"
[ -n "$dead" ] || exit 0
parent=$(tmux show-options -gqv "@parent_of_$dead")
tmux set-option -gu "@parent_of_$dead" 2>/dev/null
[ -n "$parent" ] || exit 0
# Only move focus if the parent is still alive
if tmux display-message -p -t "$parent" '' >/dev/null 2>&1; then
  tmux select-pane -t "$parent"
fi
exit 0
