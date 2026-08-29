# Ocelotl Architecture Guide

## 1. Purpose

Ocelotl is a modular provisioning framework for local bioinformatics workstations. It transforms a clean Ubuntu installation into a repeatable scientific computing environment using a Bash bootstrap and an Ansible playbook.

The architecture separates host validation, provisioning, configuration, and verification so components can evolve independently without turning the bootstrap into a monolithic installer.

## 2. Target platform

The complete workstation profile currently targets:

- Ubuntu 22.04 LTS, 24.04 LTS, or 26.04 LTS
- x86_64 / amd64 architecture
- A local workstation
- A regular user account with `sudo` privileges
- Internet access during provisioning

The bootstrap explicitly accepts the three listed Ubuntu versions. Some individual roles contain architecture mappings or may work elsewhere, but the full profile is limited to x86_64/amd64 because the current Obsidian and Godot roles use amd64/x86_64 artifacts.

Other Linux distributions, macOS, Windows, HPC clusters, and cloud environments are outside the current supported scope.

## 3. Design principles

Ocelotl favors:

- Single-purpose roles
- Reproducible and idempotent operations
- Configuration in role defaults
- Official repositories and release artifacts
- Explicit privilege escalation
- Read-only verification where practical
- Safe repeated execution
- A small bootstrap layer with orchestration logic only

Simple roles may keep installation and verification in one task file. Larger roles split their work into `install`, `configure`, and `verify` task files. This is a design convention rather than a requirement that every role has the same directory layout.

## 4. Provisioning workflow

```text
Clean supported Ubuntu installation
                |
                v
          bootstrap.sh
                |
                +-- load lib/init.sh
                +-- validate OS, sudo, network, Git, and curl
                +-- install or verify Ansible Core
                |
                v
      playbooks/workstation.yml
                |
                +-- apt -> common -> ansible
                +-- r -> conda -> java -> docker -> nextflow
                +-- vscode -> shell -> obsidian -> godot -> syncthing
                |
                v
      Provisioned local workstation
```

`bootstrap.sh` sets the repository's `ansible.cfg`, selects `sudo.ws` as the become executable when it is available, and otherwise uses `sudo`. It then runs the local inventory with `--ask-become-pass`.

## 5. Bootstrap responsibilities

The bootstrap layer prepares the host for Ansible and does not implement workstation features itself.

Its responsibilities are:

1. Resolve and load Ocelotl's internal Bash modules.
2. Verify the operating system and required host capabilities.
3. Ensure Ansible Core is installed and executable.
4. Launch `playbooks/workstation.yml` against `inventory/localhost.ini`.
5. Stop on errors and report failures through the logging helpers.

Current prerequisite checks cover:

- Supported Ubuntu version
- `sudo` access
- Internet connectivity
- Git availability
- curl availability

## 6. Workstation role order

The order in `playbooks/workstation.yml` is deliberate. It establishes prerequisites before consumers and keeps related workstation layers together.

| Order | Role | Responsibility |
| ---: | --- | --- |
| 1 | `apt` | Refresh the APT cache |
| 2 | `common` | Install shared build and command-line packages |
| 3 | `ansible` | Install and verify Ansible development tooling |
| 4 | `r` | Provision R, RStudio, system libraries, and configured R packages |
| 5 | `conda` | Install and configure Miniforge and scientific channels |
| 6 | `java` | Install and verify OpenJDK |
| 7 | `docker` | Install and configure Docker Engine and plugins |
| 8 | `nextflow` | Install and verify Nextflow after its common runtimes are available |
| 9 | `vscode` | Install Visual Studio Code and configured extensions |
| 10 | `shell` | Configure Zsh, Oh My Zsh, plugins, and terminal tools |
| 11 | `obsidian` | Install Obsidian from official release metadata |
| 12 | `godot` | Install Godot and desktop integration |
| 13 | `syncthing` | Install Syncthing and enable its user service |

The playbook uses role ordering rather than Ansible `meta` dependencies. A role should not assume that an undeclared command or file exists unless it is supplied by an earlier role or handled within the role itself.

The repository also contains a placeholder `roles/git` directory. It has no implementation and is not included in the workstation playbook, so Git user configuration remains roadmap work.

## 7. Role lifecycle

For roles with multiple phases, the preferred lifecycle is:

```text
defaults -> install -> configure -> verify
```

### Defaults

Role defaults hold configurable values such as package names, versions, download URLs, installation paths, service names, channels, and extension lists. This keeps task logic reusable and makes future customization easier.

### Install

Installation tasks add repositories, download trusted artifacts, install packages, and create required directories. They should use idempotent Ansible modules and guards such as `creates` where appropriate.

### Configure

Configuration tasks manage files, services, permissions, environment settings, and user membership. When an existing user file is replaced, the role should preserve a backup or otherwise make the behavior explicit.

### Verify

Verification tasks inspect the resulting state without changing it. Typical checks run a version command, query package state, or assert registered results. Not every small role has a separate `verify.yml`; some perform their verification inline.

## 8. Capability groups

```text
Base system
├── apt
├── common
└── ansible

Scientific computing
├── r
│   ├── R and optional RStudio Desktop
│   ├── CRAN packages
│   ├── Bioconductor packages
│   └── GitHub-hosted R packages
├── conda
│   └── Miniforge, conda-forge, and bioconda
├── java
├── docker
└── nextflow

Workstation applications
├── vscode
│   └── Nextflow, YAML, and Ansible extensions
├── shell
│   └── Zsh, Oh My Zsh, plugins, and terminal utilities
├── obsidian
├── godot
└── syncthing
```

## 9. Repository structure

```text
ocelotl/
├── bootstrap.sh                 # Public entry point
├── ansible.cfg                  # Repository-local Ansible configuration
├── inventory/
│   └── localhost.ini            # Local workstation inventory
├── playbooks/
│   ├── workstation.yml          # Complete workstation profile
│   └── r.yml                    # Focused R profile
├── lib/
│   ├── checks/                  # Readiness checks
│   ├── core/                    # Ansible orchestration
│   ├── installers/              # Bootstrap installers
│   ├── init.sh                  # Module loader
│   └── logging.sh               # Bootstrap logging
├── roles/
│   ├── apt/
│   ├── common/
│   ├── ansible/
│   ├── r/
│   ├── conda/
│   ├── java/
│   ├── docker/
│   ├── nextflow/
│   ├── vscode/
│   ├── shell/
│   ├── obsidian/
│   ├── godot/
│   └── syncthing/
├── docs/
│   └── architecture.md
├── README.md
└── CHANGELOG
```

## 10. Idempotence and failure behavior

Ocelotl is intended to converge an existing workstation as well as provision a clean one. Roles should:

- Declare desired state instead of relying on unconditional shell commands.
- Avoid reporting changes when only inspecting state.
- Refresh package metadata only when necessary.
- Use registered results to gate dependent operations.
- Preserve user configuration when replacement is necessary.
- Fail early when a required artifact, package, or verification result is unavailable.

A successful first run provisions the host. A successful second run should produce no changes unless upstream state, configuration, or requested versions have changed.

## 11. Security boundaries

Ocelotl must not:

- Store passwords, API keys, tokens, or SSH private keys.
- Run the entire repository as root.
- Modify unrelated user files.
- Install GPU drivers automatically.
- Hide privilege escalation or destructive changes.

Administrative privileges are requested only for system-level tasks. User-scoped tools and configuration should run as the invoking user.

## 12. Current scope and roadmap

The current scope is a reproducible local bioinformatics workstation with the 13 roles listed above.

Possible future profiles or roles include:

- Git user configuration
- Named bioinformatics Conda environments
- Apptainer / Singularity
- CUDA and NVIDIA tooling
- Automated multi-version Ubuntu testing
- HPC / SLURM support
- Cloud provisioning

Roadmap items are not supported capabilities until they are implemented, included in a playbook, and documented.

## 13. Definition of success

Ocelotl succeeds when a user can:

1. Clone the repository on a supported clean Ubuntu workstation.
2. Run `./bootstrap.sh`.
3. Complete provisioning without manually installing each component.
4. Run the same command again safely to confirm convergence.
5. Begin scientific work with the documented tools available.
