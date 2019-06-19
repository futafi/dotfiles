bind-key -n M-h previous-window
bind-key -n M-l next-window
bind-key -n M-k switch-client -p
bind-key -n M-j switch-client -n
bind-key k kill-pane
bind-key C-k kill-pane
bind-key C-v display-panes \; split-window -h -c "#{pane_current_path}"
bind-key C-h display-panes \; split-window -v -c "#{pane_current_path}"
unbind-key -n C-a
unbind-key -n C-q
set -g prefix ^Q
set -g prefix2 F12
bind q send-prefix
