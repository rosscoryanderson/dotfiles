if [[ -z $1  ]]; then
  SESSION=$USER
else
  SESSION=$1
fi


set -- $(stty size)
tmux -2 new-session -d -s $SESSION -x "$(($2 - 1))" -y "$(($1 - 1))"
# tmux -2 new-session -d -s $SESSION -x "$2" -y "$(($1 - 1))"


tmux new-window -t $SESSION:1 -n 'Main'

tmux split-window -h
tmux split-window -v
tmux split-window -v
tmux select-pane -t 0
tmux split-window -v


tmux resize-pane -Dt 1 25 
tmux resize-pane -Rt 0 82 
tmux resize-pane -Ut 2 21 
tmux resize-pane -Dt 4 1 

tmux send-keys -t 0 'nvim .' C-m
tmux send-keys -t 1 'git pull' C-m
tmux send-keys -t 3 'lazygit' C-m

# # Set default window
tmux select-window -t $SESSION:1

# Attach to session
tmux -2 attach-session -t $SESSION


#!/bin/bash
# SESSION=$USER
# DIR='~/dev/node'
# DIR='~/dev/node'
# DIR="~/dev/node/$1"
# if [[ ! -d "$DIR" ]]; then 
#   mkdir "$DIR"
# fi
# cd "$DIR"
# tmux resize-pane -Dt 1 6 
# tmux resize-pane -Rt 0 20 
# tmux resize-pane -Ut 2 3 
# tmux resize-pane -Dt 4 3 

# tmux resize-pane -Dt 25 1
# tmux resize-pane -D 25 -t $SESSION:1.1
# tmux select-pane -t 1
# tmux resize-pane -D 30 
#
# tmux select-pane -R
# tmux resize-pane -D 30
#
# tmux select-pane -U
# tmux select-pane -U
# tmux resize-pane -U 15 
# tmux resize-pane -R 75 


# tmux resize-pane -t 0 -R 50
# tmux resize-pane -R 50 -t $SESSION:1.0
# tmux select-pane -t 0
# tmux select-pane -U
# tmux resize-pane -R 75
#
# # tmux resize-pane -tU 20 -t 2
#
# # tmux resize-pane -U 15 -t $SESSION:1.2
# # tmux select-pane -t 2
# tmux select-pane -R
# tmux resize-pane -U 15
# tmux send-keys 'echo hi' C-m
#
#
# # tmux resize-pane -D 15 -t $SESSION:1.4
# tmux select-pane -t 4
# tmux resize-pane -D 20
# tmux send-keys 'echo world' C-m

# tmux select-pane -t 4
# tmux resize-pane -U 7
# tmux send-keys 'watch -n1 ${HOME}/bin/gpu_sensors.sh' C-m


