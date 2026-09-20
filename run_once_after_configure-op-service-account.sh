#!/bin/bash
set -e

# One-time bootstrap for a 1Password service-account token, used only by
# headless/non-interactive shells (CI-like local scripts, sandboxed coding
# agents) that have no desktop app or biometric hardware to authenticate
# with interactively. Human-interactive shells never need this — they use
# the desktop app's biometric-gated CLI integration and the gh shell plugin
# instead (see dot_config/zsh/core.zsh).
#
# The token itself never lives in this repo or in any chezmoi-managed
# dotfile: it's stored only in the OS credential store, keyed by
# "op-service-account", and read lazily by core.zsh for non-interactive
# shells only.

SERVICE="op-service-account"

already_stored() {
    if command -v security >/dev/null 2>&1; then
        security find-generic-password -a "$USER" -s "$SERVICE" >/dev/null 2>&1
    elif command -v secret-tool >/dev/null 2>&1; then
        secret-tool lookup service "$SERVICE" >/dev/null 2>&1
    else
        return 1
    fi
}

store_token() {
    local token=$1
    if command -v security >/dev/null 2>&1; then
        security add-generic-password -a "$USER" -s "$SERVICE" -w "$token" -U
        echo "Stored in macOS Keychain."
    elif command -v secret-tool >/dev/null 2>&1; then
        printf '%s' "$token" | secret-tool store --label="1Password service account" service "$SERVICE"
        echo "Stored in the Secret Service keyring."
    else
        echo "No supported credential store found (security/secret-tool)."
        echo "Install libsecret-tools/gnome-keyring, or export"
        echo "OP_SERVICE_ACCOUNT_TOKEN yourself from your own secret manager."
        return 1
    fi
}

if ! command -v security >/dev/null 2>&1 && ! command -v secret-tool >/dev/null 2>&1; then
    exit 0
fi

if already_stored; then
    exit 0
fi

echo "1Password service-account token (used only for headless/agent shells)."
echo "Leave blank to skip if you don't need headless access on this machine."
read -rs -p "Token: " token
echo
if [ -n "$token" ]; then
    store_token "$token"
fi
