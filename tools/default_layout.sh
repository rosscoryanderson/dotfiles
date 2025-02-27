if [[ -z $1  ]]; then
  SESSION=$USER
else
  SESSION=$1
fi


set -- $(stty size)
tmux -2 new-session -d -s $SESSION -x "$(($2 - 1))" -y "$(($1 - 1))"


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
tmux send-keys -t 3 'lazygit' C-m
# tmux send-keys -t 1 'git pull' C-m

# # Set default window
tmux select-window -t $SESSION:1

# Attach to session
tmux -2 attach-session -t $SESSION

