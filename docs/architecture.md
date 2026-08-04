# Ocelotl Architecture

## 1. Purpose

Ocelotl is a modular provisioning framework for bioinformatics workstations.

Its goal is to transform a clean Ubuntu installation into a reproducible scientific computing environment using a predictable, testable and extensible architecture.

The project minimizes manual configuration while promoting reproducibility, maintainability and portability across research environments.

---

## 2. Target Platform

The initial supported platform is:

- Ubuntu 22.04 LTS
- Ubuntu 24.04 LTS
- x86_64 architecture
- Local workstation
- User with sudo privileges

The following platforms are currently out of scope:

- Other Linux distributions
- macOS
- Windows
- HPC clusters
- Cloud environments

---

## 3. Design Philosophy

Ocelotl follows a simple design philosophy.

- One module, one responsibility.
- Validation is separated from installation.
- Installation is separated from configuration.
- Configuration is separated from verification.

Every component should be:

- Reproducible
- Idempotent
- Modular
- Testable
- Transparent
- Safe to execute repeatedly
- Easy to extend

The framework should avoid unnecessary global installations and clearly separate workstation provisioning from scientific workflows.

---

## 4. High-Level Workflow

```
Clean Ubuntu Installation
          │
          ▼
     bootstrap.sh
          │
          ▼
       Checks
          │
          ▼
 Install / Verify Ansible
          │
          ▼
   Execute Playbooks
          │
          ▼
    Configuration
          │
          ▼
     Verification
          │
          ▼
 Bioinformatics Workstation
```

---

## 5. Internal Architecture

```
bootstrap.sh
        │
        ▼
lib/init.sh
        │
        ▼
──────────────────────────────────

Checks
│
├── Operating System
├── sudo
├── Internet
├── Git
└── curl

↓

Installers

↓

Configuration

↓

Verification
```

The bootstrap script orchestrates the provisioning process but does not implement installation logic directly.

---

## 6. Main Components

### bootstrap.sh

Responsibilities:

- Initialize Ocelotl
- Load internal modules
- Execute system checks
- Ensure Ansible is available
- Launch the provisioning playbook
- Exit gracefully on failure

The bootstrap script should remain small and contain only orchestration logic.

---

### Checks

Checks validate that the system is ready before any installation begins.

Examples:

- Verify supported operating system
- Verify sudo privileges
- Verify Internet connectivity
- Verify Git availability
- Verify required utilities

Checks never modify the system.

---

### Installers

Installers prepare the software required to provision the workstation.

Initially:

- Ansible

Future installers may include:

- Docker
- Java
- Micromamba
- Nextflow
- R

---

### Configuration

Configuration modules customize the workstation after installation.

Examples:

- Git configuration
- Shell configuration
- Scientific environments
- Development tools

---

### Verification

Verification modules ensure that every installed component functions correctly.

Examples:

```
git --version
docker --version
java -version
nextflow -version
micromamba --version
R --version
```

Verification should fail clearly whenever a required dependency is unavailable.

---

## 7. Environment Manager

Ocelotl uses Micromamba as its default environment manager.

Its responsibility is to create isolated scientific software environments after the operating system has been provisioned.

Initial environments:

- core
- quality-control
- amplicon
- metagenomics
- transcriptomics

The first release may implement only the **core** environment.

---

## 8. Repository Structure

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
│   ├── init.sh
│   ├── logging.sh
│   ├── checks/
│   ├── installers/
│   ├── configuration/
│   ├── verification/
│   └── core/
│
├── playbooks/
├── roles/
├── environments/
├── tests/
└── .github/
```

---

## 9. Security Boundaries

Ocelotl must never:

- Store passwords
- Store API keys
- Store SSH private keys
- Execute the entire project as root
- Execute unverified remote scripts
- Modify unrelated user files
- Replace existing configurations without warning
- Install GPU drivers automatically

Administrative privileges should only be requested when required.

---

## 10. Scope for Version 0.1

Version 0.1 will include:

- Ubuntu verification
- sudo verification
- Internet verification
- Git verification
- Ansible bootstrap
- Basic system provisioning
- Micromamba installation
- Documentation

Docker, Java, Nextflow, R and bioinformatics environments will be introduced in later milestones.

---

## 11. Out of Scope

The initial release will not include:

- Scientific analysis pipelines
- Biological databases
- CUDA installation
- NVIDIA drivers
- AlphaFold
- HPC or SLURM configuration
- Cloud provisioning
- Desktop customization
- macOS support
- Windows support

---

## 12. Definition of Success

Ocelotl will be considered successful when a user can:

1. Clone the repository on a clean Ubuntu installation.
2. Execute a single documented command.
3. Obtain a fully provisioned and verified bioinformatics workstation.
4. Begin scientific work without manually installing each dependency.

```
git clone <repository>

cd Ocelotl

./bootstrap.sh
```

The entire provisioning process should be reproducible, deterministic and maintainable.