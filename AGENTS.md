# Portable Dotfiles Repository

This repository contains generic, non-sensitive development setup for dev containers, Codespaces, and disposable development environments. Assume the installer is primarily run from inside a dev container, not on a long-lived host machine.

## Scope

- Keep this repo portable and safe to make public.
- Do not add secrets, tokens, private keys, credentials, hostnames, work-specific endpoints, account IDs, or machine-specific branches.
- Do not copy SSH config, AWS config/credentials, GPG private material, `.netrc`, `.pgpass`, npm tokens, or generated machine state from other dotfiles repos.
- Prefer generic Linux/dev-container behavior. Do not add Homebrew/macOS-specific install paths to the portable setup.
- Avoid assumptions about host-level services, desktop apps, systemd, SSH agents, GUI clipboard tools, or machine-specific paths.
- Installer changes should work in minimal containers where the user may be root or may have `sudo`.

## Editing Guidance

- Keep changes small and explicit.
- Preserve simple shell scripts over introducing frameworks.
- Keep `install.sh` as the top-level orchestrator and split concern-specific setup into scripts under `install/`.
- Make installers idempotent where practical.
- Back up existing user files before replacing or symlinking them.
- Avoid destructive cleanup commands.

## Verification

- Run `bash -n install.sh` after editing the installer.
- Run `bash -n install/*.sh` after editing concern-specific install scripts.
- Run `zsh -n aliases.zsh` after editing shell aliases.
- Do not run the installer automatically unless explicitly requested.
