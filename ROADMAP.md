# Roadmap

## Technical Debt

### Configuration Management

- [ ] Fix hardcoded home directory path in btop configuration
- [ ] Move themes out of repo into downloaded resources
- [ ] Migrate application configs to ~/.config directory:
  - [ ] k9s
  - [ ] ghostty
  - [ ] lazygit
- [ ] Automate manual 1Password CLI configuration

### Architecture Decisions

- Currently using Homebrew for package management
  - Evaluating migration to Nix
  - Need to assess impact on cross-platform support
- Application configs split between ~/.config and ~/Library
  - Plan to consolidate where possible
  - Document macOS-specific exceptions

## Current Focus

### Configuration Management

- [ ] Automate 1Password CLI configuration using chezmoi
- [ ] Add Raycast configuration and settings
- [ ] Complete migration to goenv for Go version management

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

## Future Plans

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

## Completed

- [x] Initial cross-platform support
- [x] Basic 1Password integration
- [x] Automated package installation
