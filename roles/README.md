# Ocelotl roles

This directory contains the Ansible roles that make up the Ocelotl workstation.
Each role owns one capability and should remain independently understandable,
configurable, and safe to run repeatedly.

## Workstation profile

`playbooks/workstation.yml` applies the active roles in this order:

| Order | Role | Responsibility |
| ---: | --- | --- |
| 1 | `apt` | Refresh the APT package cache. |
| 2 | `common` | Install shared command-line and build prerequisites. |
| 3 | `ansible` | Install and verify Ansible development tooling. |
| 4 | `r` | Install R, optional RStudio Desktop, and configured R packages. |
| 5 | `conda` | Install and configure Miniforge and scientific channels. |
| 6 | `java` | Install and verify OpenJDK. |
| 7 | `docker` | Install Docker Engine, plugins, and user access. |
| 8 | `nextflow` | Install and verify Nextflow after its runtimes are available. |
| 9 | `vscode` | Install Visual Studio Code and configured extensions. |
| 10 | `shell` | Configure Zsh, Oh My Zsh, plugins, and terminal utilities. |
| 11 | `obsidian` | Install Obsidian from its official release artifacts. |
| 12 | `godot` | Install Godot with command-line and desktop integration. |
| 13 | `syncthing` | Install Syncthing and enable its user service. |
| 14 | `libresprite` | Install LibreSprite and expose its AppImage as a command. |

The order is intentional: base packages and runtimes are installed before the
tools that consume them. Dependencies are currently expressed by playbook order
rather than Ansible `meta` dependencies.

`playbooks/r.yml` is a focused profile that applies only the `r` role.
LibreSprite also has a `libresprite` tag for targeted execution.

## Role status

All roles listed in the workstation profile are active. `git` is an empty
placeholder and is not included in any playbook; Git identity configuration
therefore remains roadmap work.

## Role anatomy

A simple role may keep its complete implementation in `tasks/main.yml`. Larger
roles should use this lifecycle when the phases are meaningful:

```text
defaults -> install -> configure -> verify
```

- `defaults/main.yml` contains user-overridable values such as package names,
  versions, URLs, paths, channels, and extension lists.
- `tasks/install.yml` installs packages or release artifacts and creates
  required directories.
- `tasks/configure.yml` manages configuration, permissions, services, and user
  integration.
- `tasks/verify.yml` inspects the resulting state without changing it.
- `handlers/main.yml` contains actions that should run only when notified.
- `templates/` contains files rendered from variables owned by the role.

Not every role needs every directory. Do not add empty lifecycle files merely
to make role layouts identical.

## Implementation contract

Every active role should:

- Describe desired state with Ansible modules whenever possible.
- Be idempotent: an immediate second run should report no changes.
- Keep configurable values in role defaults instead of embedding them in task
  logic.
- Use `become: true` only for operations that require administrative access.
- Perform user-scoped configuration as the invoking user.
- Verify important installations with checks that use `changed_when: false`.
- Guard downloads, extraction, and shell commands so they do not run
  unconditionally.
- Preserve existing user configuration when replacement is necessary, or make
  the replacement behavior explicit.
- Avoid storing credentials, tokens, private keys, or host-specific secrets.

Roles that download external artifacts should prefer official repositories or
official release locations and should keep architecture mappings explicit.

## Adding a role

1. Create `roles/<name>/tasks/main.yml` and only the additional role directories
   that are needed.
2. Put public configuration in `roles/<name>/defaults/main.yml`.
3. Add installation, configuration, and read-only verification tasks.
4. Insert the role into the appropriate playbook after its prerequisites.
5. Update the role table in this file and the architecture guide.
6. Add a concise role README when the role has public variables, several
   lifecycle phases, external release logic, or important side effects.
7. Run syntax, lint, and idempotence validation before merging.

## Role README convention

A role-specific README should explain information that cannot be understood
quickly from `tasks/main.yml` and `defaults/main.yml`. Prefer these sections:

- Responsibility
- Guarantees
- Configuration
- Verification
- Non-goals or operational caveats

Avoid copying version numbers, URLs, or package lists into prose when the role
defaults are the authoritative source. This keeps documentation useful without
creating a second configuration that can drift.

## Validation

From the repository root, validate the complete profile with:

```bash
ansible-playbook --syntax-check playbooks/workstation.yml
ansible-lint
```

For provisioning changes, also run the workstation playbook twice and require
the second run to report no changes.
