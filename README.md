# github.com/pmpaulino/dotfiles

dotfiles, managed with [`chezmoi`](https://github.com/twpayne/chezmoi).

## Prerequisites

1. Install [1Password](https://1password.com/downloads/mac/)
2. Enable 1Password CLI in 1Password Developer Settings

## Install

```shell
sudo sh -c "$(curl -fsLS get.chezmoi.io)" -- -b /usr/local/bin # this location should work for both linux and macos, feel free to change it
chezmoi init --apply https://github.com/pmpaulino/dotfiles.git
```

This will install and initialize `chezmoi`. During this initialization, `chezmoi` will run the [install.sh](run_once_before_install.sh.tmpl) script, which will install:

- `oh-my-zsh`
- `homebrew`
- run the `brew budle` command

You will also need to manually configure the 1Password CLI GitHub plugin:

```shell
op plugin init gh
```

## Improvements

### TODO

- [ ] Automate 1Password CLI configuration using chezmoi
- [ ] Migrate application configs to ~/.config directory:
  - [ ] k9s
  - [ ] ghostty
  - [ ] lazygit
- [ ] Add Raycast configuration and settings
- [ ] Fix btop configuration to use dynamic home directory path
- [ ] Download themes during install rather than storing in repo
- [ ] Complete migration to goenv for Go version management
- [ ] Evaluate migration from Homebrew to Nix package manager

### Documentation

- [ ] Add detailed setup/installation guide
- [ ] Document templating patterns and decisions
- [ ] Add customization guide for personal preferences
- [ ] Document cross-platform differences and considerations

### Package Management

- [ ] Reorganize packages.yaml into purpose-specific groups (dev, productivity, system)
- [ ] Add version pinning for critical tools
- [ ] Document package update strategy and maintenance
- [ ] Add rationale for package selections

### Installation & Maintenance

- [ ] Add installation verification steps
- [ ] Create rollback procedures for failed installations
- [ ] Add testing framework for installation scripts
- [ ] Automate remaining manual setup steps
- [ ] Add system health checks and diagnostics

### Security & Best Practices

- [ ] Document security practices and 1Password integration
- [ ] Add checksum verification for downloaded resources
- [ ] Create backup strategy for critical configs

## Commit Convention

This repository follows [Conventional Commits](https://www.conventionalcommits.org/):

- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `chore`: Maintenance tasks
- `style`: Code style changes
- `refactor`: Code refactoring
- `test`: Adding or updating tests

Examples:

- feat(zsh): add new aliases for git commands
- fix(brew): correct package installation order
- docs(readme): update installation instructions
