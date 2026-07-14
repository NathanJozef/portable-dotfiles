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
- Installs Powerline fonts, Oh My Zsh, Powerlevel10k, and zsh plugins from `install/zsh.sh`.
- Installs `mise` if it is missing.
- Installs CLI tools from root `mise.toml` using the checked-in root `mise.lock`.
- Stows and installs the matching global mise config from `stow/portable/.config/mise/config.toml` and `stow/portable/.config/mise/mise.lock` so those tools are available in any workspace.
- Exports `MISE_GLOBAL_CONFIG_FILE="$HOME/.config/mise/config.toml"` so devcontainer-provided mise shims resolve the portable global tools.
- Imports mounted `~/.zsh_history` into Atuin once from `install/atuin.sh` when Atuin is available.
- Stows Neovim, mise, yazi, and tmux config into `$HOME` from `stow/portable`.
- Adds `source "<repo>/aliases.zsh"` to `~/.zshrc` if missing, which also sources the stowed Powerlevel10k config.
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
stow/portable/.p10k.zsh     -> ~/.p10k.zsh
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
- Powerlevel10k prompt theme
- `zsh-autosuggestions`
- `zsh-syntax-highlighting`

`mise` installs:

- `atuin`
- `eza`
- `fd`
- `fzf`
- `jq`
- `k9s`
- `kubectl`
- `lazydocker`
- `lazygit`
- `neovim`
- `opencode`
- `ripgrep`
- `tmux`
- `yazi`
- `zoxide`

## Shell Aliases

Aliases live in `aliases.zsh` and include `eza`-backed `ls`, Git helpers, Powerlevel10k config loading, `mise` activation, and `zoxide` activation.

## Neovim

The Neovim binary is installed by `mise`. The Neovim config is copied from the non-sensitive shared config in the main dotfiles repo and stowed from `stow/portable/.config/nvim`. It uses `lazy.nvim`, `mason`, `treesitter`, `telescope`, `gitsigns`, `diffview`, `neo-tree`, `harpoon`, and `conform`.
