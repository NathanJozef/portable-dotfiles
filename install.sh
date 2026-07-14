#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

log() {
  printf '[portable-dotfiles] %s\n' "$*"
}

has_command() {
  command -v "$1" >/dev/null 2>&1
}

as_root() {
  if [[ "${EUID}" -eq 0 ]]; then
    "$@"
    return
  fi

  if has_command sudo; then
    sudo "$@"
    return
  fi

  log "Need root privileges for: $*"
  log "Install sudo or run this script as root."
  return 1
}

install_packages() {
  if has_command apt-get; then
    as_root apt-get update
    as_root apt-get install -y \
      bash \
      build-essential \
      ca-certificates \
      cmake \
      curl \
      fd-find \
      fzf \
      git \
      gnupg \
      htop \
      jq \
      make \
      neovim \
      pkg-config \
      ripgrep \
      tig \
      tmux \
      tree \
      unzip \
      xz-utils \
      zoxide \
      zsh
    return
  fi

  if has_command brew; then
    brew bundle --file="$repo_dir/Brewfile"
    return
  fi

  if has_command apk; then
    as_root apk add --no-cache \
      bash \
      build-base \
      ca-certificates \
      cmake \
      curl \
      fd \
      fzf \
      git \
      gnupg \
      htop \
      jq \
      make \
      neovim \
      pkgconf \
      ripgrep \
      tig \
      tmux \
      tree \
      unzip \
      xz \
      zoxide \
      zsh
    return
  fi

  if has_command dnf; then
    as_root dnf install -y \
      bash \
      ca-certificates \
      cmake \
      curl \
      fd-find \
      fzf \
      gcc \
      gcc-c++ \
      git \
      gnupg2 \
      htop \
      jq \
      make \
      neovim \
      pkgconf-pkg-config \
      ripgrep \
      tig \
      tmux \
      tree \
      unzip \
      xz \
      zoxide \
      zsh
    return
  fi

  if has_command pacman; then
    as_root pacman -Sy --needed --noconfirm \
      base-devel \
      bash \
      ca-certificates \
      cmake \
      curl \
      fd \
      fzf \
      git \
      gnupg \
      htop \
      jq \
      make \
      neovim \
      pkgconf \
      ripgrep \
      tig \
      tmux \
      tree \
      unzip \
      xz \
      zoxide \
      zsh
    return
  fi

  log "No supported package manager found. Install system prerequisites manually."
}

install_mise() {
  if ! has_command mise; then
    log "Installing mise"
    curl https://mise.run | sh
  fi

  local mise_bin
  mise_bin="$(command -v mise 2>/dev/null || true)"

  if [[ -z "$mise_bin" && -x "$HOME/.local/bin/mise" ]]; then
    mise_bin="$HOME/.local/bin/mise"
  fi

  if [[ -z "$mise_bin" ]]; then
    log "mise was not found after installation"
    return 1
  fi

  export PATH="$HOME/.local/share/mise/shims:$HOME/.local/bin:$PATH"

  "$mise_bin" trust "$repo_dir/.config/mise/config.toml" >/dev/null 2>&1 || true
  "$mise_bin" install --yes
}

install_npm_tools() {
  if ! has_command npm; then
    log "npm not found; skipping npm global tools"
    return
  fi

  npm install --global \
    @devcontainers/cli \
    npq \
    pnpm
}

install_config_link() {
  local source_path="$1"
  local target_path="$2"

  mkdir -p "$(dirname "$target_path")"

  if [[ -L "$target_path" ]]; then
    local current_target
    current_target="$(readlink "$target_path")"
    if [[ "$current_target" == "$source_path" ]]; then
      return
    fi

    rm "$target_path"
  elif [[ -e "$target_path" ]]; then
    local backup_path
    backup_path="$target_path.backup.$(date +%Y%m%d%H%M%S)"
    log "Backing up $target_path to $backup_path"
    mv "$target_path" "$backup_path"
  fi

  ln -s "$source_path" "$target_path"
}

install_configs() {
  install_config_link "$repo_dir/.config/nvim" "$HOME/.config/nvim"
  install_config_link "$repo_dir/.config/mise" "$HOME/.config/mise"
  install_config_link "$repo_dir/.config/yazi" "$HOME/.config/yazi"
  install_config_link "$repo_dir/.tmux.conf" "$HOME/.tmux.conf"

  local zshrc="$HOME/.zshrc"
  local source_line="source \"$repo_dir/aliases.zsh\""

  touch "$zshrc"
  if ! grep -Fqx "$source_line" "$zshrc"; then
    printf '\n%s\n' "$source_line" >> "$zshrc"
  fi
}

main() {
  install_packages
  install_configs
  install_mise
  install_npm_tools

  log "Install complete. Restart your shell or run: source ~/.zshrc"
}

main "$@"
