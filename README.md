# Ocelotl

[![Latest tag](https://img.shields.io/badge/latest%20tag-v1.0.0-blue)](https://github.com/erickdelgadillo/ocelotl/tree/v1.0.0)
![Ubuntu](https://img.shields.io/badge/Ubuntu-22.04%20%7C%2024.04%20%7C%2026.04-E95420)
![Ansible](https://img.shields.io/badge/Ansible-automation-red)
[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)

> Build a reproducible bioinformatics workstation from a clean Ubuntu installation using Ansible.

Ocelotl turns a new Ubuntu workstation into a ready-to-use scientific computing environment. A small Bash bootstrap validates the host, installs Ansible Core when necessary, and runs a modular, repeatable Ansible playbook.

## Supported platform

| Requirement | Supported |
| --- | --- |
| Operating system | Ubuntu 22.04 LTS, 24.04 LTS, and 26.04 LTS |
| Full workstation architecture | x86_64 / amd64 |
| Execution target | Local workstation |
| Privileges | User account with `sudo` access |

The bootstrap rejects unsupported Ubuntu versions before provisioning. The complete workstation profile is currently limited to x86_64/amd64 because some desktop applications use architecture-specific artifacts.

## What Ocelotl provisions

The main workstation playbook runs these roles in order:

| Role | Capability |
| --- | --- |
| `apt` | Refreshes the APT package cache |
| `common` | Installs shared build and command-line prerequisites |
| `ansible` | Installs Ansible development tooling, including `ansible-lint` |
| `r` | Installs R, optional RStudio Desktop, system libraries, and configured CRAN, Bioconductor, and GitHub packages |
| `conda` | Installs and configures Miniforge with conda-forge and bioconda channels |
| `java` | Installs and verifies OpenJDK for JVM-based workflows |
| `docker` | Installs Docker Engine, Buildx, and the Compose plugin; configures the user and service |
| `nextflow` | Installs and verifies Nextflow |
| `vscode` | Installs Visual Studio Code and the configured Nextflow, YAML, and Ansible extensions |
| `shell` | Installs Zsh, Oh My Zsh, plugins, and common terminal tools; manages `.zshrc` with a backup |
| `obsidian` | Installs the latest available amd64 Debian package from official Obsidian releases |
| `godot` | Installs the configured Godot release, command symlink, icon, and desktop entry |
| `syncthing` | Configures the official repository and enables the Syncthing user service |

## Provisioning flow

```text
bootstrap.sh
    |
    +-- validate Ubuntu, sudo, network, Git, and curl
    +-- install or verify Ansible Core
    +-- run playbooks/workstation.yml
            |
            +-- base system: apt -> common -> ansible
            +-- scientific stack: r -> conda -> java -> docker -> nextflow
            +-- workstation tools: vscode -> shell -> obsidian -> godot -> syncthing
                    |
                    +-- provisioned and verified workstation
```

See the [architecture guide](docs/architecture.md) for design decisions, role ordering, repository structure, and extension guidelines.

## Installation

```bash
git clone https://github.com/erickdelgadillo/ocelotl.git
cd ocelotl
./bootstrap.sh
```

The bootstrap asks for the privilege-escalation password when Ansible starts. Roles are designed to be idempotent, so the same command can be run again to converge the workstation after an interrupted or partial setup.

## Project principles

- Reproducible and automated provisioning
- Modular roles with explicit responsibilities
- Idempotent operations that are safe to repeat
- Verification of installed components where practical
- Configuration through role defaults instead of scattered hard-coded values
- No credentials or private keys stored in the repository


Keep changes focused, preserve role idempotence, and update the documentation whenever the workstation profile or supported platform changes.

## Roadmap

Potential future work includes:

- Git user configuration
- Named bioinformatics Conda environments
- Apptainer / Singularity
- CUDA and NVIDIA tooling
- Automated testing across supported Ubuntu versions
- HPC / SLURM and cloud provisioning profiles

These items are not part of the current workstation playbook.

## Definition of success
Ocelotl succeeds when a user can:

Clone the repository on a supported clean Ubuntu workstation.
Run ./bootstrap.sh.
Complete provisioning without manually installing each component.
Run the same command again safely to confirm convergence.
Begin scientific work with the documented tools available.


## Release status

The latest tag is `v1.0.0`. Features merged since that tag are documented under [Unreleased](CHANGELOG) and will remain unreleased until a new tag and GitHub Release are approved and published.

## Why Ocelotl?

“Ocelotl” is the Nahuatl word for the ocelot, a wild feline native to the Americas. The name reflects adaptability, precision, and resilience.Qualities that also define reproducible scientific computing.

## License

Ocelotl is available under the [MIT License](LICENSE).
