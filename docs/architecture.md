# Ocelotl Architecture Guide

## 1. Purpose

Ocelotl is a modular provisioning framework for bioinformatics workstations.

Its goal is to transform a clean Ubuntu installation into a reproducible scientific computing environment using a predictable, testable and extensible architecture.

The project minimizes manual configuration while promoting reproducibility, maintainability and portability across research environments.

---

## 2. Target Platform

Current supported platform:

- Ubuntu 22.04 LTS
- Ubuntu 24.04 LTS
- x86_64 architecture
- Local workstation
- User with sudo privileges

Currently out of scope:

- Other Linux distributions
- macOS
- Windows
- HPC clusters
- Cloud environments

---

## 3. Design Philosophy

Every component in Ocelotl follows the same design principles.

- Single responsibility
- Reproducible
- Idempotent
- Modular
- Self-contained
- Verifiable
- Testable
- Transparent
- Safe to execute repeatedly
- Easy to extend

The project deliberately separates installation, configuration and verification in order to simplify maintenance and future development.

---

## 4. Provisioning Workflow

```
Clean Ubuntu Installation
            │
            ▼
      bootstrap.sh
            │
            ▼
   Bootstrap Validation
            │
            ▼
     Ensure Ansible
            │
            ▼
 Execute workstation.yml
            │
            ▼
──────────── Roles ────────────

install
      │
configure
      │
verify

───────────────────────────────
            │
            ▼
Provisioned Bioinformatics Workstation
```

---

## 5. Role Lifecycle

Every role follows the same lifecycle.

```
defaults
      │
      ▼
install
      │
      ▼
configure
      │
      ▼
verify
```

### defaults

Contains every configurable parameter used by the role.

Examples:

- package names
- installation paths
- URLs
- versions
- service names

No hardcoded values should appear inside tasks whenever possible.

---

### install

Responsible only for installing software.

Responsibilities include:

- Downloading files
- Installing packages
- Creating directories
- Adding repositories

Installation should never perform configuration.

---

### configure

Responsible only for configuring installed software.

Examples:

- Generate configuration files
- Enable services
- Configure user permissions
- Configure environment variables

Configuration should never install software.

---

### verify

Responsible only for demonstrating that the role completed successfully.

Typical workflow:

```
Read
    ↓
Register
    ↓
Assert
```

Verification never modifies the system.

Every verification should clearly report success or failure.

---

## 6. Bootstrap Responsibilities

The bootstrap layer exists only to prepare the system for Ansible.

Responsibilities:

- Initialize Ocelotl
- Load internal Bash modules
- Execute prerequisite checks
- Install Ansible when necessary
- Launch the provisioning playbook
- Exit gracefully on failure

The bootstrap script should remain small and contain orchestration logic only.

---

## 7. Checks

Bootstrap checks validate that the machine is ready before provisioning begins.

Current checks include:

- Supported operating system
- sudo privileges
- Internet connectivity
- Git availability
- curl availability

Checks never modify the system.

---

## 8. Current Role Dependencies

```
common
│
├── apt

conda
│
└── common

java
│
└── common

docker
│
└── common

nextflow
├── java
├── docker
└── conda
```

Dependencies should remain explicit and minimal.

---

## 9. Repository Structure

```
Ocelotl/
│
├── bootstrap.sh
├── README.md
├── CHANGELOG
├── docs/
│   └── architecture.md
│
├── lib/
│   ├── checks/
│   ├── core/
│   ├── installers/
│   ├── configuration/
│   ├── verification/
│   ├── init.sh
│   └── logging.sh
│
├── inventory/
├── playbooks/
│
├── roles/
│   ├── common/
│   ├── conda/
│   ├── java/
│   ├── docker/
│   ├── nextflow/
│   └── ...
│
└── ansible.cfg
```

---

## 10. Security Principles

Ocelotl must never:

- Store passwords
- Store API keys
- Store SSH private keys
- Execute the entire project as root
- Execute unverified remote scripts
- Modify unrelated user files
- Replace existing user configurations without warning
- Install GPU drivers automatically

Administrative privileges should only be requested when required.

---

## 11. Scope of Version 1.0

Version 1.0 provides:

- Bootstrap framework
- Automatic Ansible installation
- Common package installation
- Conda installation and configuration
- Java installation
- Docker installation and configuration
- Nextflow installation
- Verification framework
- Modular role architecture
- Project documentation

---

## 12. Out of Scope

Future releases may include:

- Git configuration
- VS Code configuration
- Shell customization
- R
- Bioinformatics Conda environments
- Apptainer / Singularity
- CUDA
- NVIDIA drivers
- HPC / SLURM support
- Cloud provisioning

---

## 13. Definition of Success

Ocelotl is considered successful when a user can:

1. Clone the repository on a clean Ubuntu installation.
2. Execute a single documented command.
3. Obtain a fully provisioned and verified bioinformatics workstation.
4. Begin scientific work without manually installing each dependency.

```bash
git clone <repository>

cd ocelotl

./bootstrap.sh
```

The complete provisioning process must be reproducible, deterministic, maintainable and safe to execute repeatedly.