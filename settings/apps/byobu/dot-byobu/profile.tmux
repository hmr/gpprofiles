source $BYOBU_PREFIX/share/byobu/profiles/tmux
set -g default-terminal "screen-256color"
set -g status-right '#(byobu-status tmux_right)'$BYOBU_DATE$BYOBU_TIME
set -g mouse on

