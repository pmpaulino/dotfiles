# Aliases
# Keep aliases organized and documented

# System aliases
alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"

# Git aliases (if not using oh-my-zsh git plugin)
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline'

# Directory navigation
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# List aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Safety aliases
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Quick edits
alias zshconfig='$EDITOR ~/.zshrc'
alias zshreload='source ~/.zshrc'

# Development aliases
alias py='python3'
alias pip='pip3'
alias serve='python3 -m http.server'

# Docker aliases
alias d='docker'
alias dc='docker-compose'
alias dps='docker ps'
alias dpsa='docker ps -a'

# Kubernetes aliases
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get services'
alias kgd='kubectl get deployments'
