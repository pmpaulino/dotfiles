# Environment variables and PATH configuration

# GitHub
# gh auth is handled by the 1Password shell plugin (see `op plugin init gh`
# in dot_zshrc.tmpl) — it injects a short-lived token per invocation via
# biometric approval. Do not export GITHUB_TOKEN/GH_TOKEN here: doing so
# bypasses the plugin for every gh call in every shell.
export GITHUB_USER="pmpaulino"

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

# kubectl plugins (krew)
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# PostgreSQL (if using Homebrew; works on both macOS and Linux)
LIBPQ_PREFIX="$(brew --prefix libpq 2>/dev/null)"
if [[ -n "$LIBPQ_PREFIX" && -d "$LIBPQ_PREFIX" ]]; then
    export PATH="$LIBPQ_PREFIX/bin:$PATH"
    export LDFLAGS="-L$LIBPQ_PREFIX/lib"
    export CPPFLAGS="-I$LIBPQ_PREFIX/include"
fi
