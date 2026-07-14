#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

log() {
  printf '[portable-dotfiles] %s\n' "$*"
}

has_command() {
  command -v "$1" >/dev/null 2>&1
}

append_once() {
  local file="$1"
  local line="$2"

  touch "$file"
  if ! grep -Fqx "$line" "$file"; then
    printf '%s\n' "$line" >> "$file"
  fi
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
      ca-certificates \
      curl \
      git \
      gnupg \
      stow \
      tig \
      tree \
      unzip \
      xz-utils \
      zsh
    return
  fi

  if has_command apk; then
    as_root apk add --no-cache \
      bash \
      ca-certificates \
      curl \
      git \
      gnupg \
      stow \
      tig \
      tree \
      unzip \
      xz \
      zsh
    return
  fi

  if has_command dnf; then
    as_root dnf install -y \
      bash \
      ca-certificates \
      curl \
      git \
      gnupg2 \
      stow \
      tig \
      tree \
      unzip \
      xz \
      zsh
    return
  fi

  if has_command pacman; then
    as_root pacman -Sy --needed --noconfirm \
      bash \
      ca-certificates \
      curl \
      git \
      gnupg \
      stow \
      tig \
      tree \
      unzip \
      xz \
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

  export PATH="$HOME/.local/bin:$HOME/.local/share/mise/shims:$PATH"

  "$mise_bin" trust "$repo_dir/mise.toml" >/dev/null 2>&1 || true
  "$mise_bin" install --yes --locked --cd "$repo_dir"

  local required_commands=(eza nvim lazygit lazydocker yazi zoxide)
  local command_name
  for command_name in "${required_commands[@]}"; do
    if ! "$mise_bin" which --cd "$repo_dir" "$command_name" >/dev/null 2>&1; then
      log "mise did not install required command: $command_name"
      return 1
    fi
  done
}

backup_stow_target() {
  local target_path="$1"

  if [[ -L "$target_path" ]]; then
    rm "$target_path"
  elif [[ -e "$target_path" ]]; then
    local backup_path
    backup_path="$target_path.backup.$(date +%Y%m%d%H%M%S)"
    log "Backing up $target_path to $backup_path"
    mv "$target_path" "$backup_path"
  fi
}

install_configs() {
  if ! has_command stow; then
    log "stow not found; skipping config installation"
    return
  fi

  backup_stow_target "$HOME/.config/nvim"
  backup_stow_target "$HOME/.config/mise"
  backup_stow_target "$HOME/.config/yazi"
  backup_stow_target "$HOME/.tmux.conf"

  stow --dir="$repo_dir/stow" --target="$HOME" --restow portable

  local zshrc="$HOME/.zshrc"
  local source_line="source \"$repo_dir/aliases.zsh\""

  append_once "$zshrc" "$source_line"
}

main() {
  install_packages
  "$repo_dir/install/zsh.sh"
  install_configs
  install_mise

  log "Install complete. Restart your shell or run: source ~/.zshrc"
}

main "$@"
