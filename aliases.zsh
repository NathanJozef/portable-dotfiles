# File listing aliases
alias ls='eza --icons'
alias ll='eza --icons --long'
alias la='eza --icons --all'
alias lla='eza --icons --long --all'
alias lt='eza --icons --tree'

# Git workflow aliases
alias goto-gitroot='cd $(gitroot)'
alias gitroot='git rev-parse --show-toplevel'
alias git-force-push='git push --force-with-lease'
alias git-amend-commit='git commit --amend --no-edit'

# Tool initialization
if command -v mise >/dev/null 2>&1; then
    eval "$(mise activate zsh)"
fi

if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
fi

export PATH="$HOME/.local/bin:$PATH"
