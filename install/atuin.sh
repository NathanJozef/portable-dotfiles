#!/usr/bin/env bash
set -euo pipefail

log() {
  printf '[portable-dotfiles:atuin] %s\n' "$*"
}

has_command() {
  command -v "$1" >/dev/null 2>&1
}

main() {
  if ! has_command atuin; then
    log "atuin not found; skipping history import"
    return
  fi

  local history_file="$HOME/.zsh_history"
  local marker_file="$HOME/.local/share/atuin/.portable-dotfiles-zsh-history-imported"

  if [[ ! -s "$history_file" ]]; then
    log "No zsh history found at $history_file; skipping import"
    return
  fi

  if [[ -e "$marker_file" ]]; then
    log "zsh history was already imported; skipping"
    return
  fi

  mkdir -p "$(dirname "$marker_file")"
  log "Importing zsh history into atuin"
  atuin import zsh
  touch "$marker_file"
}

main "$@"
