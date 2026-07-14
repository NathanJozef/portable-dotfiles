#!/usr/bin/env bash
set -euo pipefail

log() {
  printf '[portable-dotfiles:zsh] %s\n' "$*"
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

main() {
  if ! has_command zsh; then
    log "zsh not found; skipping zsh setup"
    return
  fi

  if [[ ! -d "$HOME/.local/share/fonts/PowerlineSymbols" ]]; then
    local fonts_dir
    fonts_dir="$(mktemp -d)"
    log "Installing Powerline fonts"
    git clone --depth 1 https://github.com/powerline/fonts.git "$fonts_dir"
    "$fonts_dir/install.sh"
    rm -rf "$fonts_dir"
  fi

  if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    log "Installing Oh My Zsh"
    RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi

  local custom_dir="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
  mkdir -p "$custom_dir/plugins"

  if [[ ! -d "$custom_dir/plugins/zsh-autosuggestions" ]]; then
    git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions "$custom_dir/plugins/zsh-autosuggestions"
  fi

  if [[ ! -d "$custom_dir/plugins/zsh-syntax-highlighting" ]]; then
    git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git "$custom_dir/plugins/zsh-syntax-highlighting"
  fi

  if [[ ! -d "$custom_dir/themes/powerlevel10k" ]]; then
    git clone --depth 1 https://github.com/romkatv/powerlevel10k.git "$custom_dir/themes/powerlevel10k"
  fi

  local zshrc="$HOME/.zshrc"
  append_once "$zshrc" 'export ZSH="$HOME/.oh-my-zsh"'
  append_once "$zshrc" 'ZSH_THEME="powerlevel10k/powerlevel10k"'
  append_once "$zshrc" 'plugins=(git zsh-autosuggestions zsh-syntax-highlighting)'
  append_once "$zshrc" 'source "$ZSH/oh-my-zsh.sh"'
  append_once "$zshrc" '[[ -f ~/.p10k.zsh && -z "${PORTABLE_DOTFILES_P10K_LOADED:-}" ]] && source ~/.p10k.zsh && export PORTABLE_DOTFILES_P10K_LOADED=1'
}

main "$@"
