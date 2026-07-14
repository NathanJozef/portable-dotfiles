# File listing aliases
alias ls='eza --icons'
alias ll='eza --icons --long'
alias la='eza --icons --all'
alias lla='eza --icons --long --all'
alias lt='eza --icons --tree'

# Python aliases
alias python=python3
alias pip=pip3

# Git workflow aliases
alias goto-gitroot='cd $(gitroot)'
alias gitroot='git rev-parse --show-toplevel'
alias git-force-push='git push --force-with-lease'
alias git-amend-commit='git commit --amend --no-edit'

# Node aliases
unalias npm 2>/dev/null

npm() {
    if [[ ( "$1" == "install" || "$1" == "i" ) && $# -gt 1 ]]; then
        local arg

        for arg in "${@:2}"; do
            if [[ "$arg" == -* ]]; then
                command npm "$@"
                return
            fi
        done

        shift
        npq install "$@"
        return
    fi

    command npm "$@"
}

# Tool initialization
if command -v mise >/dev/null 2>&1; then
    eval "$(mise activate zsh)"
fi

if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
fi

export GOPATH="$HOME/.go"
export PATH="$HOME/.local/bin:$GOPATH/bin:$PATH"
