

if tmux info &> /dev/null; then 
  ./sesh_menu.sh
fi

if [[ -z $(pgrep tmux) ]]; then
  tmux attach 
  ./sesh_menu.sh
else
  
fi
