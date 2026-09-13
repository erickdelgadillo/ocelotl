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

## Development and deployment environments

Ocelotl is developed as a real workstation-provisioning project rather than as an isolated Ansible exercise.

Changes are primarily developed and tested on a Linux laptop, then applied to a substantially more powerful custom-built workstation used for scientific computing and bioinformatics. This provides a practical development → validation → deployment workflow across two machines with different hardware capabilities.

### Development system

Ocelotl is primarily developed and validated on an:

**ASUS ROG Strix G513IM**
- **CPU:** AMD Ryzen 7 4800h
- **Memory:** 64 GB DDR4 RAM 3200 MT/s
- **Discrete GPU:** NVIDIA GeForce RTX 3060 Laptop GPU, 6 GB VRAM
- **Integrated GPU:** AMD Radeon Vega Graphics
- **Storage:** 2 × 1 TB NVMe SSDs
- **Operating system:** Ubuntu 26.04 LTS
- **Architecture:** x86_64
- **Storage configuration:** encrypted Ubuntu installation using LUKS/LVM,
  alongside Windows and a separate NTFS data volume

Ocelotl is ultimately deployed on a custom-built scientific workstation:
**ASUS ROG Strix B650E-E Gaming WiFi**
- **CPU:** AMD Ryzen 9 9950X3D
- **Memory:** 192 GB DDR5 RAM 5000 MT/s
- **Discrete GPU:** NVIDIA GeForce RTX 4070 Ti
- **Integrated GPU:** AMD Radeon Graphics (RDNA 2, 2 CUs)
- **Storage:** 1 TB NVMe Gen5 SSDs + 2 TB NVMe Gen4 SSDs + 1 TB NVMe Gen4 SSDs + 2 x 2Tb SSD SATA 
- **Operating system:** Ubuntu 26.04 LTS
- **Architecture:** x86_64
- **Storage configuration:** encrypted Ubuntu installation using LUKS/LVM,
  alongside Windows and a separate NTFS data volume

The primary deployment target is a **custom workstation designed, assembled, and configured by the repository author** for computational biology workloads.

```text
Development laptop
      |
      |  develop and validate
      v
Git / GitHub
      |
      |  versioned configuration
      v
Ocelotl / Ansible
      |
      |  provision
      v
Custom scientific workstation
      |
      +-- R / Bioconductor
      +-- Conda / Bioconda
      +-- Docker
      +-- Nextflow / nf-core
      +-- development tools
      +-- scientific applications
```

This separation also reduces the risk of testing unfinished infrastructure changes directly on the main workstation while demonstrating that the same provisioning model can be applied across heterogeneous Linux hardware.

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
            |      conda# Ocelotl

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

## Development and deployment environments

Ocelotl is developed as a real workstation-provisioning project rather than as an isolated Ansible exercise.

Changes are primarily developed and tested on a Linux laptop, then applied to a substantially more powerful custom-built workstation used for scientific computing and bioinformatics. This provides a practical development → validation → deployment workflow across two machines with different hardware capabilities.

### Development system

The primary development machine is an **ASUS ROG Strix G513IM** laptop running Ubuntu.

- Ubuntu Linux
- x86_64 / amd64
- 64 GB RAM
- Used for Ansible role development, configuration changes, documentation, and workflow validation

The laptop provides a separate environment in which provisioning changes can be developed and tested before they are applied to the main computational workstation.

### Scientific workstation

The primary deployment target is a **custom workstation designed, assembled, and configured by the repository author** for computational biology workloads.

- AMD Ryzen 9 9950X3D
- ~192 GB DDR5 RAM
- NVIDIA GeForce RTX 4070 Ti
- Ubuntu Linux
- NVIDIA/CUDA-capable compute environment
- x86_64 / amd64

The workstation is intended for substantially heavier workloads, including large biological datasets, local bioinformatics pipelines, Nextflow/nf-core workflows, and other compute- and memory-intensive analyses.

Ocelotl provides the reproducible software layer on top of this hardware. Instead of rebuilding the scientific environment manually after system changes or reinstallations, the desired workstation configuration is expressed as code and managed through Ansible.

```text
Development laptop
      |
      |  develop and validate
      v
Git / GitHub
      |
      |  versioned configuration
      v
Ocelotl / Ansible
      |
      |  provision
      v
Custom scientific workstation
      |
      +-- R / Bioconductor
      +-- Conda / Bioconda
      +-- Docker
      +-- Nextflow / nf-core
      +-- development tools
      +-- scientific applications
```

This separation also reduces the risk of testing unfinished infrastructure changes directly on the main workstation while demonstrating that the same provisioning model can be applied across heterogeneous Linux hardware.

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
- Cloud provisioning profiles# Ocelotl

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

## Development and deployment environments

Ocelotl is developed as a real workstation-provisioning project rather than as an isolated Ansible exercise.

Changes are primarily developed and tested on a Linux laptop, then applied to a substantially more powerful custom-built workstation used for scientific computing and bioinformatics. This provides a practical development → validation → deployment workflow across two machines with different hardware capabilities.

### Development system

The primary development machine is an **ASUS ROG Strix G513IM** laptop running Ubuntu.

- Ubuntu Linux
- x86_64 / amd64
- 64 GB RAM
- Used for Ansible role development, configuration changes, documentation, and workflow validation

The laptop provides a separate environment in which provisioning changes can be developed and tested before they are applied to the main computational workstation.

### Scientific workstation

The primary deployment target is a **custom workstation designed, assembled, and configured by the repository author** for computational biology workloads.

- AMD Ryzen 9 9950X3D
- ~192 GB DDR5 RAM
- NVIDIA GeForce RTX 4070 Ti
- Ubuntu Linux
- NVIDIA/CUDA-capable compute environment
- x86_64 / amd64

The workstation is intended for substantially heavier workloads, including large biological datasets, local bioinformatics pipelines, Nextflow/nf-core workflows, and other compute- and memory-intensive analyses.

Ocelotl provides the reproducible software layer on top of this hardware. Instead of rebuilding the scientific environment manually after system changes or reinstallations, the desired workstation configuration is expressed as code and managed through Ansible.

```text
Development laptop
      |
      |  develop and validate
      v
Git / GitHub
      |
      |  versioned configuration
      v
Ocelotl / Ansible
      |
      |  provision
      v
Custom scientific workstation
      |
      +-- R / Bioconductor
      +-- Conda / Bioconda
      +-- Docker
      +-- Nextflow / nf-core
      +-- development tools
      +-- scientific applications
```

This separation also reduces the risk of testing unfinished infrastructure changes directly on the main workstation while demonstrating that the same provisioning model can be applied across heterogeneous Linux hardware.

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
- Named bioinformatics Conda environments# Ocelotl

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

## Development and deployment environments

Ocelotl is developed as a real workstation-provisioning project rather than as an isolated Ansible exercise.

Changes are primarily developed and tested on a Linux laptop, then applied to a substantially more powerful custom-built workstation used for scientific computing and bioinformatics. This provides a practical development → validation → deployment workflow across two machines with different hardware capabilities.

### Development system

The primary development machine is an **ASUS ROG Strix G513IM** laptop running Ubuntu.

- Ubuntu Linux
- x86_64 / amd64
- 64 GB RAM
- Used for Ansible role development, configuration changes, documentation, and workflow validation

The laptop provides a separate environment in which provisioning changes can be developed and tested before they are applied to the main computational workstation.

### Scientific workstation

The primary deployment target is a **custom workstation designed, assembled, and configured by the repository author** for computational biology workloads.

- AMD Ryzen 9 9950X3D
- ~192 GB DDR5 RAM
- NVIDIA GeForce RTX 4070 Ti
- Ubuntu Linux
- NVIDIA/CUDA-capable compute environment
- x86_64 / amd64

The workstation is intended for substantially heavier workloads, including large biological datasets, local bioinformatics pipelines, Nextflow/nf-core workflows, and other compute- and memory-intensive analyses.

Ocelotl provides the reproducible software layer on top of this hardware. Instead of rebuilding the scientific environment manually after system changes or reinstallations, the desired workstation configuration is expressed as code and managed through Ansible.

```text
Development laptop
      |
      |  develop and validate
      v
Git / GitHub
      |
      |  versioned configuration
      v
Ocelotl / Ansible
      |
      |  provision
      v
Custom scientific workstation
      |
      +-- R / Bioconductor
      +-- Conda / Bioconda
      +-- Docker
      +-- Nextflow / nf-core
      +-- development tools
      +-- scientific applications
```

This separation also reduces the risk of testing unfinished infrastructure changes directly on the main workstation while demonstrating that the same provisioning model can be applied across heterogeneous Linux hardware.

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

## Development and deployment environments

Ocelotl is developed as a real workstation-provisioning project rather than as an isolated Ansible exercise.

Changes are primarily developed and tested on a Linux laptop, then applied to a substantially more powerful custom-built workstation used for scientific computing and bioinformatics. This provides a practical development → validation → deployment workflow across two machines with different hardware capabilities.

### Development system

The primary development machine is an **ASUS ROG Strix G513IM** laptop running Ubuntu.

- Ubuntu Linux
- x86_64 / amd64
- 64 GB RAM
- Used for Ansible role development, configuration changes, documentation, and workflow validation

The laptop provides a separate environment in which provisioning changes can be developed and tested before they are applied to the main computational workstation.

### Scientific workstation

The primary deployment target is a **custom workstation designed, assembled, and configured by the repository author** for computational biology workloads.

- AMD Ryzen 9 9950X3D
- ~192 GB DDR5 RAM
- NVIDIA GeForce RTX 4070 Ti
- Ubuntu Linux
- NVIDIA/CUDA-capable compute environment
- x86_64 / amd64

The workstation is intended for substantially heavier workloads, including large biological datasets, local bioinformatics pipelines, Nextflow/nf-core workflows, and other compute- and memory-intensive analyses.

Ocelotl provides the reproducible software layer on top of this hardware. Instead of rebuilding the scientific environment manually after system changes or reinstallations, the desired workstation configuration is expressed as code and managed through Ansible.

```text
Development laptop
      |
      |  develop and validate
      v
Git / GitHub
      |
      |  versioned configuration
      v
Ocelotl / Ansible
      |
      |  provision
      v
Custom scientific workstation
      |
      +-- R / Bioconductor
      +-- Conda / Bioconda
      +-- Docker
      +-- Nextflow / nf-core
      +-- development tools
      +-- scientific applications
```

This separation also reduces the risk of testing unfinished infrastructure changes directly on the main workstation while demonstrating that the same provisioning model can be applied across heterogeneous Linux hardware.

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

---# Ocelotl

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

## Development and deployment environments

Ocelotl is developed as a real workstation-provisioning project rather than as an isolated Ansible exercise.

Changes are primarily developed and tested on a Linux laptop, then applied to a substantially more powerful custom-built workstation used for scientific computing and bioinformatics. This provides a practical development → validation → deployment workflow across two machines with different hardware capabilities.

### Development system

The primary development machine is an **ASUS ROG Strix G513IM** laptop running Ubuntu.

- Ubuntu Linux
- x86_64 / amd64
- 64 GB RAM
- Used for Ansible role development, configuration changes, documentation, and workflow validation

The laptop provides a separate environment in which provisioning changes can be developed and tested before they are applied to the main computational workstation.

### Scientific workstation

The primary deployment target is a **custom workstation designed, assembled, and configured by the repository author** for computational biology workloads.

- AMD Ryzen 9 9950X3D
- ~192 GB DDR5 RAM
- NVIDIA GeForce RTX 4070 Ti
- Ubuntu Linux
- NVIDIA/CUDA-capable compute environment
- x86_64 / amd64

The workstation is intended for substantially heavier workloads, including large biological datasets, local bioinformatics pipelines, Nextflow/nf-core workflows, and other compute- and memory-intensive analyses.

Ocelotl provides the reproducible software layer on top of this hardware. Instead of rebuilding the scientific environment manually after system changes or reinstallations, the desired workstation configuration is expressed as code and managed through Ansible.

```text
Development laptop
      |
      |  develop and validate
      v
Git / GitHub
      |
      |  versioned configuration
      v
Ocelotl / Ansible
      |
      |  provision
      v
Custom scientific workstation
      |
      +-- R / Bioconductor
      +-- Conda / Bioconda
      +-- Docker
      +-- Nextflow / nf-core
      +-- development tools
      +-- scientific applications
```

This separation also reduces the risk of testing unfinished infrastructure changes directly on the main workstation while demonstrating that the same provisioning model can be applied across heterogeneous Linux hardware.

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
