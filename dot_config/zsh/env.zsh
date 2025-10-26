# Environment variables and PATH configuration

# GitHub
export GITHUB_USER="pmpaulino"
export GITHUB_TOKEN="op://Private/xndcgybadcw6stdi6o6xjexexq/token"

# 1Password
export OP_ACCOUNT="my.1password.com"

# Go
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"

# Node.js (fnm)
eval "$(fnm env --use-on-cd --shell zsh)"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# Homebrew (configured in main template)
# Platform-specific Homebrew paths are handled in dot_zshrc.tmpl

# Additional PATH entries
export PATH="$HOME/.local/bin:$PATH"

# Application-specific
export K9S_CONFIG="$HOME/.config/k9s"

# PostgreSQL (if using Homebrew)
if [[ -d "/opt/homebrew/opt/libpq" ]]; then
    export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
    export LDFLAGS="-L/opt/homebrew/opt/libpq/lib"
    export CPPFLAGS="-I/opt/homebrew/opt/libpq/include"
fi
