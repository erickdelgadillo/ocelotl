# Ocelotl — Current Project Checkpoint

Last verified: 2026-09-25

Repository:
`erickdelgadillo/ocelotl`

Default branch:
`main`

Verified main commit:
`aa89874994c490b5713cef56b912d647fb1b01fc`

Current GitHub `main` is the implementation source of truth.

## Purpose

Ocelotl provisions a reproducible scientific and bioinformatics workstation from a supported Ubuntu installation using a small Bash bootstrap plus modular Ansible roles.

```text
clean Ubuntu workstation
        ↓
./bootstrap.sh
        ↓
host validation
        ↓
install / verify Ansible Core
        ↓
playbooks/workstation.yml
        ↓
modular roles
        ↓
scientific workstation
```

## Supported full-workstation scope

Current repository documentation targets:

- Ubuntu 22.04 LTS
- Ubuntu 24.04 LTS
- Ubuntu 26.04 LTS
- x86_64 / amd64
- local workstation execution
- regular user with sudo access
- internet access during provisioning

Other operating systems and deployment targets are outside the current supported full-workstation profile.

## Bootstrap architecture

Current bootstrap-related structure includes:

```text
bootstrap.sh
lib/
├── init.sh
├── logging.sh
├── checks/
│   ├── ansible.sh
│   ├── curl.sh
│   ├── git.sh
│   ├── internet.sh
│   ├── os.sh
│   └── sudo.sh
├── installers/
│   └── ansible.sh
└── core/
    └── ansible.sh
```

Responsibilities:

- validate host readiness;
- verify supported Ubuntu;
- verify sudo, internet, Git, and curl;
- install or verify Ansible Core;
- launch the workstation playbook.

## Current workstation playbook

`playbooks/workstation.yml` currently invokes:

```text
apt
common
ansible
r
conda
java
docker
nextflow
vscode
shell
obsidian
godot
syncthing
libresprite
```

`libresprite` is tagged separately.

A focused `playbooks/r.yml` also exists for the R role.

## CI and idempotence

Current GitHub Actions workflow:

`.github/workflows/ansible-ci.yml`

It performs:

1. checkout;
2. install `ansible` and `ansible-lint`;
3. syntax check;
4. `ansible-lint`;
5. first complete provisioning run;
6. second complete provisioning run;
7. verify second-run recap contains:

```text
changed=0
unreachable=0
failed=0
```

This is the automated convergence/idempotence check.

CI on `ubuntu-latest` is not equivalent to real clean-machine validation on every supported Ubuntu release.

## Current status

### IMPLEMENTED

- Bash bootstrap and readiness checks;
- Ansible Core bootstrap/orchestration;
- local inventory;
- modular workstation playbook;
- base system roles;
- R/RStudio provisioning;
- Miniforge / conda-forge / bioconda provisioning;
- Java;
- Docker;
- Nextflow;
- VS Code and configured extensions;
- Zsh / Oh My Zsh environment;
- Obsidian;
- Godot;
- Syncthing;
- LibreSprite;
- CI syntax/lint/provisioning/idempotence workflow;
- role-level documentation for major components.

### VALIDATED

Validation mechanisms are implemented in CI and many roles include explicit verification tasks.

Historical real-machine validation also exists.

A fresh session should inspect current CI status before claiming that the exact current commit passes every supported environment.

### DOCUMENTED

Architecture, bootstrap flow, roles, supported platforms, installation, idempotence, development workflow, release status, and roadmap are documented.

### PLANNED / NOT CURRENTLY IMPLEMENTED

- Git user configuration;
- named bioinformatics Conda environments;
- Apptainer / Singularity;
- CUDA / NVIDIA tooling;
- automated testing across all supported Ubuntu versions;
- HPC / SLURM profiles;
- cloud profiles;
- additional scientific CLI utilities;
- optional workstation profiles.

## Known documentation drift

Two small inconsistencies exist on the verified `main` state:

1. `README.md` displays a badge linking to `v1.0.0`, while its release-status section states `v1.2.0` as the latest tagged release.
2. `docs/architecture.md` describes the workstation as 13 roles and omits `libresprite`, while the actual playbook and root README include `libresprite`.

The playbook is authoritative for the current role inventory.
