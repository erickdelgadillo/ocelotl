# Mentat-Core Architecture

## 1. Purpose

Mentat-Core provisions a reproducible Ubuntu workstation for bioinformatics development and scientific computing.

Its purpose is to reduce the time, inconsistency and manual work involved in configuring a new computer.

## 2. Target platform

The first supported platform is:

* Ubuntu 22.04 LTS and Ubuntu 24.04 LTS
* x86_64 architecture
* Local workstation
* User with sudo privileges

Other Linux distributions, macOS, Windows, HPC clusters and cloud environments are initially out of scope.

## 3. Design principles

Mentat-Core should be:

* Reproducible
* Idempotent
* Modular
* Transparent
* Testable
* Safe to run repeatedly
* Easy to extend

The project should avoid unnecessary global installations and should separate system provisioning from scientific workflows.

## 4. High-level workflow

```text
Clean Ubuntu installation
        ↓
bootstrap.sh
        ↓
Install or verify Ansible
        ↓
Run Ansible playbook
        ↓
Install system dependencies
        ↓
Configure development tools
        ↓
Install Micromamba environments
        ↓
Verify installation
        ↓
Bioinformatics-ready workstation
```

## 5. Main components

### bootstrap.sh

Responsibilities:

* Detect the operating system
* Verify that Ubuntu 22.04 LTS and Ubuntu 24.04 LTS is supported
* Check sudo availability
* Install Ansible if required
* Run the main Ansible playbook
* Stop with clear error messages when a step fails

The bootstrap script should remain small and should not contain the complete installation logic.

### Ansible

Ansible manages persistent system configuration.

Responsibilities:

* Install system packages
* Configure Git
* Install Docker
* Install Java
* Install Nextflow
* Install Micromamba
* Install R
* Apply optional shell configuration
* Run verification tasks

### Micromamba

Micromamba manages isolated scientific software environments.

Initial environments:

* core
* quality-control
* amplicon
* metagenomics
* transcriptomics

The first release may only implement the `core` environment.

### Verification

Verification scripts confirm that installed components are available and functional.

Examples:

```bash
git --version
docker --version
java -version
nextflow -version
micromamba --version
R --version
```

Verification should fail clearly when a required component is missing.

## 6. Repository structure

```text
mentat-core/
├── bootstrap.sh
├── ansible.cfg
├── inventory/
├── playbooks/
├── roles/
├── environments/
├── scripts/
├── tests/
├── docs/
└── .github/workflows/
```

## 7. Security boundaries

Mentat-Core must not:

* Store passwords, API keys or access tokens
* Store SSH private keys
* Execute the entire project as root
* Download and execute unverified remote scripts without inspection
* Modify unrelated user files
* Replace existing configuration without warning
* Install GPU drivers automatically

Administrative privileges should be requested only for tasks that require them.

## 8. Scope for version 0.1

Version 0.1 will provide:

* Ubuntu detection
* Ansible bootstrap
* Installation of basic system utilities
* Installation of Git
* Installation of Micromamba
* Basic verification
* Documentation

Docker, R, Java, Nextflow and bioinformatics environments may be added in later milestones.

## 9. Out of scope

The initial project will not include:

* Scientific analysis pipelines
* Biological databases
* AlphaFold
* CUDA or NVIDIA driver installation
* HPC or SLURM configuration
* Cloud infrastructure
* Graphical desktop customization
* macOS or Windows support

## 10. Definition of success

Mentat-Core will be considered functional when a user can clone the repository on a clean Ubuntu 22.04 LTS or Ubuntu 24.04 LTS installation, run one documented command and obtain a verified working environment without manually installing each dependency.
