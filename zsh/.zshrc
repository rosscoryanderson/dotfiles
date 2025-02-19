function sesh-sessions() {
  {
    exec </dev/tty
    exec <&1
    local session
    session=$(sesh list -t -c | fzf --height 40% --reverse --border-label ' sesh ' --border --prompt '⚡  ')
    zle reset-prompt > /dev/null 2>&1 || true
    [[ -z "$session" ]] && return
    sesh connect $session
  }
}

zle     -N             sesh-sessions
bindkey -M emacs '\es' sesh-sessions
bindkey -M vicmd '\es' sesh-sessions
bindkey -M viins '\es' sesh-sessions

eval "$(starship init zsh)"

alias gs="git status"
alias ga="git add ."
alias gl="git log"
alias gc="git commit -m"

alias lg="lazygit"

alias tm="~/.dotfiles/tools/default_layout.sh"
alias tml="~/.dotfiles/tools/default_layout_init.sh"

alias docker="colima"


