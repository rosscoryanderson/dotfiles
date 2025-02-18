

# if tmux info &> /dev/null; then 
#   ./sesh_menu.sh
# fi
if [ -z "$1" ]; then
  if [[ -z $(pgrep tmux) ]]; then
    tmux attach 
    ./sesh_menu.sh
  else
    case $1 in
      new) "~/.dotfiles/tools/.tmconfig/{$2}.sh" ;;
      # new) ~/.dotfiles/tools/.tmconfig/"{$2}".sh ;;
        ?) "echo operation not supported" ;;
    esac
    # ./.tmconfig/"{$2}"
  # echo "Error: missing first parameter."
  # exit 1
  fi
fi
  
