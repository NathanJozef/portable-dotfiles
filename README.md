# Portable Dotfiles

Generic development dotfiles for dev containers, Codespaces, and disposable Linux/macOS environments.

This repo intentionally excludes machine-specific and sensitive setup from the main dotfiles repo, including SSH config, AWS config/credentials, GPG key setup, pgpass, netrc, host-specific stow logic, and desktop app configuration.

## Install

```bash
./install.sh
```

The installer:

- Installs system prerequisites with `apt`, `brew`, `apk`, `dnf`, or `pacman` when available.
- Installs `mise` if it is missing.
- Installs language and CLI tools from `stow/portable/.config/mise/config.toml`.
- Installs npm global tools used by the aliases.
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
- `fd`
- `fzf`
- `git`
- `gnupg`
- `htop`
- `jq`
- `ripgrep`
- `tig`
- `tmux`
- `tree`
- `zoxide`
- `zsh`

`mise` installs:

- `awscli`
- `aws-sam-cli`
- `devcontainer-cli`
- `eza`
- `go`
- `helm`
- `java`
- `k9s`
- `kubectl`
- `neovim`
- `node`
- `npm`
- `pnpm`
- `python`
- `rust`
- `terraform`
- `yazi`

Homebrew also installs `circumflex`, `mise`, `opencode`, and `stow`.

## Shell Aliases

Aliases live in `aliases.zsh` and include `eza`-backed `ls`, Python aliases, a small npm wrapper using `npq`, Git helpers, `mise` activation, and `zoxide` activation.

## Neovim

The Neovim binary is installed by `mise`. The Neovim config is copied from the non-sensitive shared config in the main dotfiles repo and stowed from `stow/portable/.config/nvim`. It uses `lazy.nvim`, `mason`, `treesitter`, `telescope`, `gitsigns`, `diffview`, `neo-tree`, `harpoon`, and `conform`.
