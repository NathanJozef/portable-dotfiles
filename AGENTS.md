# Portable Dotfiles Repository

This repository contains generic, non-sensitive development setup for dev containers, Codespaces, and disposable development environments.

## Scope

- Keep this repo portable and safe to make public.
- Do not add secrets, tokens, private keys, credentials, hostnames, work-specific endpoints, account IDs, or machine-specific branches.
- Do not copy SSH config, AWS config/credentials, GPG private material, `.netrc`, `.pgpass`, npm tokens, or generated machine state from other dotfiles repos.
- Prefer generic Linux/dev-container behavior. macOS/Homebrew support is fine when it stays optional and portable.

## Editing Guidance

- Keep changes small and explicit.
- Preserve simple shell scripts over introducing frameworks.
- Make installers idempotent where practical.
- Back up existing user files before replacing or symlinking them.
- Avoid destructive cleanup commands.

## Verification

- Run `bash -n install.sh` after editing the installer.
- Run `zsh -n aliases.zsh` after editing shell aliases.
- Do not run the installer automatically unless explicitly requested.
