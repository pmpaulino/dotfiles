# github.com/pmpaulino/dotfiles

dotfiles, managed with [`chezmoi`](https://github.com/twpayne/chezmoi).

## Prerequisites

1. Install [1Password](https://1password.com/downloads/mac/)
2. Enable 1Password CLI in 1Password Developer Settings

## Install

```shell
GITHUB_USERNAME=pmpaulino sh -c "$(curl -fsLS get.chezmoi.io/lb)" -- init --apply $GITHUB_USERNAME
```

This will install and initialize `chezmoi`. During this initialization, `chezmoi` will run the [install.sh](run_once_before_install.sh.tmpl) script, which will install:

- `oh-my-zsh`
- `homebrew`
- run the `brew budle` command

You will also need to manually configure the 1Password CLI GitHub plugin:

```shell
op plugin init gh
```

You should also disable rancher desktop managing your dotfiles by running:

```shell
rdctl set --application.path-management-strategy manual
```

## TODO

- [ ] configure 1Password CLI via chezmoi
- [ ] mv k9s configuration to ~/.config
- [ ] mv ghostty configuration to ~/.config
- [ ] mv lazygit configuration to ~/.config
- [ ] add Raycast configuration
- [ ] Fix the hardcoded home dir in dot_config/btop/btop.conf
- [ ] Remove themes from this repo, dl them from the internet as apart of the install script
