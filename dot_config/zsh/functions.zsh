# Custom functions
# Keep functions organized and well-documented
#
# NAMING CONVENTION: Use descriptive names with hyphens to avoid conflicts
# with Oh-My-Zsh aliases (e.g., git-commit-all instead of gcm)
# Common conflicting aliases: gcp, gcm, glg, gst, gco, gcb, etc.

# gcloud project switcher
gcp-switch() {
    local project
    project=$(gcloud projects list --format="table(projectId,name,projectNumber)" | fzf | awk '{print $1}')
    if [ -n "$project" ]; then
        gcloud config set project "$project"
        gcloud auth application-default set-quota-project "$project"
        echo "Switched to project: $project"
    fi
}

# Create directory and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Extract various archive formats
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar e "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1" ;;
            *.7z)        7z x "$1"        ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Find and kill process
killport() {
    local port=$1
    if [ -z "$port" ]; then
        echo "Usage: killport <port>"
        return 1
    fi
    local pid=$(lsof -ti:$port)
    if [ -n "$pid" ]; then
        kill -9 $pid
        echo "Killed process on port $port (PID: $pid)"
    else
        echo "No process found on port $port"
    fi
}


# Docker cleanup
dclean() {
    docker system prune -f
    docker volume prune -f
    docker network prune -f
}

# Weather function (requires curl)
weather() {
    local city=${1:-"New York"}
    curl -s "wttr.in/$city"
}

# Create a new directory and initialize git
newrepo() {
    mkdir -p "$1" && cd "$1"
    git init
    echo "# $1" > README.md
    git add README.md
    git commit -m "Initial commit"
}
