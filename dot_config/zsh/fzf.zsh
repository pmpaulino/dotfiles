# fzf configuration
# Dynamic theme switching based on system appearance

# Function to get fzf colors based on current system theme
_get_fzf_colors() {
    # Check if system is in dark mode (macOS)
    if [[ "$(defaults read -g AppleInterfaceStyle 2>/dev/null)" == "Dark" ]]; then
        # Catppuccin Mocha (dark theme) - using simple, valid color format
        echo "--color=bg:#1e1e2e,fg:#cdd6f4,hl:#f38ba8,fg+:#cdd6f4,bg+:#313244,hl+:#f38ba8,info:#cba6f7,prompt:#cba6f7,pointer:#f5e0dc,marker:#f5e0dc,spinner:#f5e0dc,header:#f38ba8"
    else
        # Catppuccin Latte (light theme) - using simple, valid color format
        echo "--color=bg:#eff1f5,fg:#4c4f69,hl:#d20f39,fg+:#4c4f69,bg+:#ccd0da,hl+:#d20f39,info:#ea76cb,prompt:#ea76cb,pointer:#dc8a78,marker:#dc8a78,spinner:#dc8a78,header:#d20f39"
    fi
}

# Base fzf options (without colors)
export FZF_DEFAULT_OPTS=" \
    --multi \
    --preview 'bat --style=numbers --color=always --line-range :500 {}' \
    --preview-window 'right:60%:wrap' \
    --bind 'ctrl-/:change-preview-window(down|hidden|)' \
    --bind 'ctrl-y:execute-silent(echo {} | pbcopy)+abort' \
    --bind 'ctrl-t:toggle-all' \
    --bind 'ctrl-s:toggle-sort' \
    --select-1 --exit-0"

# Dynamic fzf wrapper that sets colors each time
fzf() {
    local fzf_colors=$(_get_fzf_colors)
    command fzf $fzf_colors "$@"
}

# Enhanced fzf key bindings and options
export FZF_CTRL_T_OPTS=" \
    --walker-skip .git,node_modules,target,dist,build \
    --preview 'bat --style=numbers --color=always --line-range :500 {}' \
    --bind 'ctrl-/:change-preview-window(down|hidden|)' \
    --bind 'ctrl-y:execute-silent(echo {} | pbcopy)+abort' \
    --select-1 --exit-0"

export FZF_CTRL_R_OPTS=" \
    --preview 'echo {}' \
    --preview-window down:3:hidden:wrap \
    --bind '?:toggle-preview' \
    --bind 'ctrl-y:execute-silent(echo {} | pbcopy)+abort' \
    --no-sort --exact"

export FZF_ALT_C_OPTS=" \
    --walker-skip .git,node_modules,target,dist,build \
    --preview 'tree -C {} | head -200' \
    --bind 'ctrl-/:change-preview-window(down|hidden|)'"

# Git integration functions
fzf-git-files() {
    local fzf_colors=$(_get_fzf_colors)
    git ls-files | fzf $fzf_colors --multi --preview 'bat --style=numbers --color=always --line-range :500 {}'
}

fzf-git-branches() {
    local fzf_colors=$(_get_fzf_colors)
    git branch -a | sed 's/remotes\///' | sort -u | fzf $fzf_colors --multi --preview 'git log --oneline --graph {} | head -20'
}

fzf-git-commits() {
    local fzf_colors=$(_get_fzf_colors)
    git log --oneline --graph --decorate | fzf $fzf_colors --multi --preview 'git show --stat {}'
}

# Enhanced history search
fzf-history-widget() {
    local selected
    local fzf_colors=$(_get_fzf_colors)
    selected=$(fc -l 1 | fzf $fzf_colors --tac --no-sort --exact --query="$LBUFFER" --preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview' --bind 'ctrl-y:execute-silent(echo {} | pbcopy)+abort')
    if [[ -n "$selected" ]]; then
        LBUFFER="$selected"
        zle redisplay
    fi
}

# Directory navigation with fzf
fzf-cd() {
    local dir
    local fzf_colors=$(_get_fzf_colors)
    dir=$(find ${1:-.} -path '*/\.*' -prune -o -type d -print 2> /dev/null | fzf $fzf_colors --preview 'tree -C {} | head -200' --bind 'ctrl-/:change-preview-window(down|hidden|)') && cd "$dir"
}

# Process search with fzf
fzf-kill() {
    local pid
    local fzf_colors=$(_get_fzf_colors)
    pid=$(ps -ef | fzf $fzf_colors --multi --preview 'ps -p {} -o pid,ppid,cmd --no-headers' --bind 'ctrl-/:change-preview-window(down|hidden|)' | awk '{print $2}') && kill -9 $pid
}

# Key bindings
zle -N fzf-history-widget
bindkey '^R' fzf-history-widget
bindkey '^T' fzf-cd

# Source fzf
source <(fzf --zsh)
