set-window-option -g xterm-keys on
#unbind-key -n M-Up
#unbind-key -n M-Down
#unbind-key -n M-Left
#unbind-key -n M-Right

bind-key -n M-S-Up display-panes \; select-pane -U
bind-key -n M-S-Down display-panes \; select-pane -D
bind-key -n M-S-Left display-panes \; select-pane -L
bind-key -n M-S-Right display-panes \; select-pane -R

unbind-key -n C-a
set -g prefix ^A
set -g prefix2 F12
bind a send-prefix
