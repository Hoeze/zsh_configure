set-window-option -g xterm-keys on
unbind-key -n M-Up
unbind-key -n M-Down
unbind-key -n M-Left
unbind-key -n M-Right
unbind-key -n M-S-Up
unbind-key -n M-S-Down
unbind-key -n M-S-Left
unbind-key -n M-S-Right

bind-key -n M-S-Left previous-window
bind-key -n M-S-Right next-window
bind-key -n M-S-Up switch-client -p
bind-key -n M-S-Down switch-client -n

bind-key -n M-Up display-panes \; select-pane -U
bind-key -n M-Down display-panes \; select-pane -D
bind-key -n M-Left display-panes \; select-pane -L
bind-key -n M-Right display-panes \; select-pane -R

unbind-key -n C-a
set -g prefix ^A
set -g prefix2 F12
bind a send-prefix
