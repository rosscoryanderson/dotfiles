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
source <(fzf --zsh)

alias gs="git status"
alias ga="git add ."
alias gl="git log"
alias gc="git commit -m"

alias ghsw="gh auth switch"

alias lg="lazygit"

alias tmn="~/.dotfiles/tools/default_layout.sh"
alias tmi="~/.dotfiles/tools/default_layout_init.sh"
alias tm="tmux attach"

alias tml="tmux resizep -L"
alias tmd="tmux resizep -D"
alias tmu="tmux resizep -U"
alias tmr="tmux resizep -R"

alias reload="source ~/.zshrc"

# alias docker="colima"

# Temporarily disabled while using 13 for SWM
#PSQL_PATH="/Applications/Postgres.app/Contents/Versions/latest/bin"
#PATH="$PATH:$PSQL_PATH"

alias pn="npx pnpm@9.15.4"

alias ls="eza --color=always --long --git --icons=always --no-user --no-time --no-permissions --all --hyperlink --group-directories-first -o -I .DS_Store"
alias lst="eza --color=always --long --git --icons=always --no-user --no-time --no-permissions --no-filesize --all --hyperlink --group-directories-first -o -I .DS_Store --tree --level=2"

BAT_THEME="OneHalfDark"
alias lsf="fzf --preview 'bat --style=numbers --color=always {}'"

alias claude-update="npm install -g @anthropic-ai/claude-code"

alias sshp="ssh-add ~/.ssh/id_ed25519"
alias sshw="ssh-add ~/.ssh/id_ed25519_work"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/rossanderson/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# bun completions
[ -s "/Users/rossanderson/.bun/_bun" ] && source "/Users/rossanderson/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

### WANEWS ###
eval "$(jenv init -)"
eval "$(rbenv init -)"
export ANDROID_HOME=~/Library/Android/sdk
PSQL_PATH="/Applications/Postgres.app/Contents/Versions/13/bin"
PATH="$PATH:$PSQL_PATH"
### WANEWS ###

export PATH=~/Library/Android/sdk/tools:$PATH
export PATH=~/Library/Android/sdk/platform-tools:$PATH
