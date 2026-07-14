# Portable Dotfiles

Generic development dotfiles for dev containers, Codespaces, and disposable Linux environments. The primary target is running inside a dev container, so this setup intentionally avoids installing language runtimes and toolchains that should come from the dev container image.

This repo intentionally excludes machine-specific and sensitive setup from the main dotfiles repo, including SSH config, AWS config/credentials, GPG key setup, pgpass, netrc, host-specific stow logic, and desktop app configuration.

## Install

```bash
./install.sh
```

The installer:

- Installs system prerequisites with `apt`, `apk`, `dnf`, or `pacman` when available.
- Runs concern-specific install scripts from `install/`, starting with `install/zsh.sh`.
- Installs Powerline fonts, Oh My Zsh, the agnoster theme, and zsh plugins from `install/zsh.sh`.
- Installs `mise` if it is missing.
- Installs CLI tools from `stow/portable/.config/mise/config.toml` using the checked-in `stow/portable/.config/mise/mise.lock`.
- Stows Neovim, mise, yazi, and tmux config into `$HOME` from `stow/portable`.
- Adds `source "<repo>/aliases.zsh"` to `~/.zshrc` if missing.
- Backs up existing config targets before replacing them.

## Stow Layout

Portable home config lives under:

```text
stow/portable/
```

For example:

```text
stow/portable/.config/nvim -> ~/.config/nvim
stow/portable/.config/mise -> ~/.config/mise
stow/portable/.config/yazi -> ~/.config/yazi
stow/portable/.tmux.conf    -> ~/.tmux.conf
```

## Included Tools

System/package-manager tools include:

- `bash`
- `curl`
- `git`
- `gnupg`
- `stow`
- `tig`
- `tree`
- `zsh`

Shell setup includes:

- Powerline fonts
- Oh My Zsh
- `agnoster` prompt theme
- `zsh-autosuggestions`
- `zsh-syntax-highlighting`

`mise` installs:

- `awscli`
- `aws-sam-cli`
- `devcontainer-cli`
- `eza`
- `fd`
- `fzf`
- `helm`
- `jq`
- `k9s`
- `kubectl`
- `lazydocker`
- `neovim`
- `ripgrep`
- `terraform`
- `tmux`
- `yazi`
- `zoxide`

## Shell Aliases

Aliases live in `aliases.zsh` and include `eza`-backed `ls`, Git helpers, `mise` activation, and `zoxide` activation.

## Neovim

The Neovim binary is installed by `mise`. The Neovim config is copied from the non-sensitive shared config in the main dotfiles repo and stowed from `stow/portable/.config/nvim`. It uses `lazy.nvim`, `mason`, `treesitter`, `telescope`, `gitsigns`, `diffview`, `neo-tree`, `harpoon`, and `conform`.
