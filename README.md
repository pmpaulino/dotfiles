# github.com/pmpaulino/dotfiles

Personal dotfiles managed with [`chezmoi`](https://github.com/twpayne/chezmoi), featuring:

- Cross-platform support (macOS and Linux)
- Secure secrets management with 1Password
- Automated package installation with Homebrew and apt
- Extensive development tooling configuration
- Terminal customization with zsh and oh-my-zsh

## Features

### 🔐 Security-First Approach

- 1Password integration for secure secrets management
- SSH and GPG key configuration
- Secure git signing setup

### 🛠️ Development Environment

- Comprehensive Git configuration with conditional includes
- Language support: Go, Python, Node.js
- Container tools: Docker, Kubernetes, Helm
- Infrastructure tools: Terraform, AWS CLI

### 📱 Terminal & Shell

- zsh with oh-my-zsh
- Custom aliases and functions
- Syntax highlighting
- Command auto-completion
- Directory jumping with zoxide

### 🎨 Theme & Styling

- Catppuccin Mocha theme across tools
- Configured for:
  - bat
  - btop
  - helix
  - k9s
  - lazygit

### 🖥️ Window Management

- AeroSpace window manager configuration (macOS)
- Workspace organization
- Custom keybindings

## Prerequisites

1. Install [1Password](https://1password.com/downloads/mac/)
2. Enable 1Password CLI in 1Password → Developer Settings
3. Configure 1Password SSH agent

## Installation

### Install chezmoi and initialize the dotfiles

```shell
sudo sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /usr/local/bin # this location should work for both linux and macos, feel free to change it
chezmoi init --apply https://github.com/pmpaulino/dotfiles.git
```

### Configure 1Password CLI GitHub integration

```shell
op plugin init gh
```

## Structure

```text
.
├── .chezmoidata/          # Template data files
├── dot_config/            # User configuration files
├── dot_zshrc.tmpl         # Shell configuration
├── private_dot_ssh/       # SSH configuration
└── run_once_*.sh.tmpl     # Installation scripts
```

## Customization

### Adding New Packages

Edit `.chezmoidata/packages.yaml` to add:

- Homebrew formulae and casks
- Linux apt packages
- App Store applications (macOS)

### Modifying Shell Configuration

The `dot_zshrc.tmpl` file contains:

- Environment variables
- Path configurations
- Aliases
- Plugin settings

### Client-Specific Settings

Separate Git configurations exist for different contexts:

- Personal (`dot_gitconfig.tmpl`)
- Client-specific (`Projects/*/dot_gitconfig.tmpl`)

## Maintenance

### Updates

- Make changes to dotfiles via `chezmoi edit`
- Apply local changes with `chezmoi apply`
- Commit changes to remote dotfiles, when ready
- Update local dotfiles repo from remote with `chezmoi update`

### Commit Convention

This repository follows [Conventional Commits](https://www.conventionalcommits.org/):

- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `chore`: Maintenance tasks
- `style`: Code style changes
- `refactor`: Code refactoring
