# Core zsh configuration
# Basic settings that should always be loaded

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='cursor --wait'
fi

# XDG Base Directory Specification
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CONFIG_DIRS="/etc/xdg"

# Autocompletion
autoload -Uz compinit
zstyle ':completion:*' menu select
fpath+=~/.zfunc

# Syntax highlighting (if available; Homebrew on macOS/Linux or system)
BREW_PREFIX="$(brew --prefix 2>/dev/null)"
if [[ -n "$BREW_PREFIX" && -f "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
    source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
elif [[ -f "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" ]]; then
    source "/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
fi

# zoxide (smart cd)
eval "$(zoxide init zsh)"

# thefuck (command correction)
eval $(thefuck --alias)

# Cross-platform tool configurations
# 1Password CLI
if [ -f "$HOME/.config/op/plugins.sh" ]; then
    source "$HOME/.config/op/plugins.sh"
fi

# 1Password service-account token, for headless/non-interactive shells only
# (CI-like scripts, sandboxed agents without desktop-app/biometric access).
# Interactive shells use the plugin/desktop integration above instead.
# See run_once_after_configure-op-service-account.sh for how it's stored.
if [ -z "$OP_SERVICE_ACCOUNT_TOKEN" ] && [ ! -t 0 ]; then
    if command -v security >/dev/null 2>&1; then
        OP_SERVICE_ACCOUNT_TOKEN="$(security find-generic-password -a "$USER" -s op-service-account -w 2>/dev/null)"
    elif command -v secret-tool >/dev/null 2>&1; then
        OP_SERVICE_ACCOUNT_TOKEN="$(secret-tool lookup service op-service-account 2>/dev/null)"
    fi
    [ -n "$OP_SERVICE_ACCOUNT_TOKEN" ] && export OP_SERVICE_ACCOUNT_TOKEN
fi

# kubectl completion
if command -v kubectl &>/dev/null; then
    source <(kubectl completion zsh)
fi

# ngrok completion
if command -v ngrok &>/dev/null; then
    eval "$(ngrok completion)"
fi

# goenv (if installed)
if command -v goenv &>/dev/null; then
    eval "$(goenv init -)"
fi

# rye (Python package manager)
if [ -f "$HOME/.rye/env" ]; then
    source "$HOME/.rye/env"
fi
