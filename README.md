# Ocelotl

[![Ansible CI](https://github.com/erickdelgadillo/ocelotl/actions/workflows/ansible-ci.yml/badge.svg)](https://github.com/erickdelgadillo/ocelotl/actions/workflows/ansible-ci.yml)
![Ansible](https://img.shields.io/badge/Ansible-automation-red)
![Ubuntu](https://img.shields.io/badge/Ubuntu-22.04%20%7C%2024.04%20%7C%2026.04-E95420)
[![Latest tag](https://img.shields.io/badge/latest%20tag-v1.0.0-blue)](https://github.com/erickdelgadillo/ocelotl/tree/v1.0.0)
[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)

> Build a reproducible scientific and bioinformatics workstation from a clean Ubuntu installation using Ansible.

Ocelotl turns a new Ubuntu workstation into a ready-to-use scientific computing environment.

A small Bash bootstrap validates the host, installs Ansible Core when necessary, and launches a modular Ansible playbook that provisions scientific software, development tools, desktop applications, and workflow infrastructure.

---

## Supported platform

| Requirement | Supported |
| --- | --- |
| Operating system | Ubuntu 22.04 LTS, 24.04 LTS, and 26.04 LTS |
| Full workstation architecture | x86_64 / amd64 |
| Execution target | Local workstation |
| Privileges | User account with `sudo` access |

The bootstrap rejects unsupported Ubuntu versions before provisioning.

The complete workstation profile is currently limited to x86_64/amd64 because some desktop applications use architecture-specific artifacts.

---

## What Ocelotl provisions

The main workstation playbook runs modular roles with clearly separated responsibilities.

| Role | Capability |
| --- | --- |
| `apt` | Refreshes the APT package cache |
| `common` | Installs shared build tools and command-line prerequisites |
| `ansible` | Installs Ansible development tooling, including `ansible-lint` |
| `r` | Installs R, optional RStudio Desktop, system libraries, and configured CRAN, Bioconductor, and GitHub packages |
| `conda` | Installs and configures Miniforge with conda-forge and bioconda channels |
| `java` | Installs and verifies OpenJDK for JVM-based workflows |
| `docker` | Installs Docker Engine, Buildx, and the Compose plugin; configures the user and service |
| `nextflow` | Installs and verifies Nextflow |
| `vscode` | Installs Visual Studio Code and configured Nextflow, YAML, and Ansible extensions |
| `shell` | Installs Zsh, Oh My Zsh, plugins, and common terminal tools; manages `.zshrc` with backup |
| `obsidian` | Installs the latest available amd64 Debian package from official Obsidian releases |
| `godot` | Installs the configured Godot release, command symlink, icon, and desktop entry |
| `libresprite` | Installs LibreSprite for pixel-art and sprite development |
| `syncthing` | Configures the official repository and enables the Syncthing user service |

---

## Provisioning flow

```text
bootstrap.sh
    |
    +-- validate Ubuntu, sudo, network, Git, and curl
    |
    +-- install or verify Ansible Core
    |
    +-- run playbooks/workstation.yml
            |
            +-- base system
            |      apt
            |      common
            |      ansible
            |
            +-- scientific stack
            |      r
            |      conda
            |      java
            |      docker
            |      nextflow
            |
            +-- workstation tools
                   vscode
                   shell
                   obsidian
                   godot
                   libresprite
                   syncthing
                        |
                        +-- provisioned workstation
```

See the [architecture guide](docs/architecture.md) for design decisions, role ordering, repository structure, and extension guidelines.

---

## Installation

Clone the repository:

```bash
git clone https://github.com/erickdelgadillo/ocelotl.git
cd ocelotl
```

Run the bootstrap:

```bash
./bootstrap.sh
```

The bootstrap performs host validation and starts Ansible provisioning.

When privilege escalation is required, Ansible requests the appropriate `sudo` credentials.

Roles are designed to converge toward the desired workstation state, allowing provisioning to be safely repeated after interrupted or partial installations.

---

## Project principles

Ocelotl is developed around several principles:

- Reproducible workstation provisioning
- Modular Ansible roles with explicit responsibilities
- Idempotent operations that are safe to repeat
- Verification of installed components where practical
- Configuration through role defaults rather than scattered hard-coded values
- Minimal manual intervention after bootstrap
- No credentials or private keys stored in the repository
- Documentation kept synchronized with the implemented workstation profile

Changes should remain focused, preserve role idempotence, and update documentation whenever supported platforms, tools, or provisioning behavior change.

---

## Continuous integration

Pull requests and changes to `main` are automatically validated with GitHub Actions.

The CI workflow performs:

- Ansible syntax validation with `ansible-playbook --syntax-check`
- Static analysis with `ansible-lint`
- A complete first provisioning run
- A second provisioning run to test convergence
- Verification that the second run completes with:

```text
changed=0
unreachable=0
failed=0
```

The second execution acts as an idempotence test: after the workstation reaches its intended state, running the same playbook again should not introduce additional changes.

This CI strategy helps detect syntax errors, Ansible quality problems, provisioning failures, and non-idempotent tasks before changes reach `main`.

---

## Development workflow

Changes are developed through short-lived branches and reviewed through pull requests.

Typical workflow:

```text
main
  |
  +-- feature branch
         |
         +-- modify
         +-- validate
         +-- commit
         +-- push
         +-- pull request
                |
                +-- CI
                +-- review
                +-- merge
                       |
                       +-- main
```

The `main` branch represents the stable development state of the workstation configuration.

---

## Definition of success

Ocelotl succeeds when a user can:

1. Clone the repository on a supported clean Ubuntu workstation.
2. Run `./bootstrap.sh`.
3. Complete provisioning without manually installing each component.
4. Run the provisioning process again without introducing unnecessary changes.
5. Begin scientific and development work with the documented tools available.

---

## Roadmap

Potential future work includes:

- Git user configuration
- Named bioinformatics Conda environments
- Apptainer / Singularity
- CUDA and NVIDIA tooling
- Automated testing across all supported Ubuntu versions
- HPC / SLURM provisioning profiles
- Cloud provisioning profiles
- Additional scientific command-line utilities
- Optional workstation profiles for different use cases

These items are not part of the current workstation playbook unless explicitly marked as implemented.

---

## Release status

The latest tagged release is:

```text
v1.0.0
```

Features merged since that tag are documented under [Unreleased](CHANGELOG) and remain unreleased until a new version tag and GitHub Release are approved and published.

---

## Why Ocelotl?

**Ocelotl** is the Nahuatl word for the ocelot, a wild feline native to the Americas.

The name reflects adaptability, precision, and resilience — qualities that also characterize reproducible scientific computing.

---

## License

Ocelotl is available under the [MIT License](LICENSE).
