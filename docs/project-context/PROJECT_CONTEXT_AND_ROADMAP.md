# Ocelotl — Project Context and Roadmap

## Why Ocelotl exists

Ocelotl treats a scientific workstation as reproducible infrastructure.

Instead of manually rebuilding a bioinformatics environment after reinstallations or hardware changes, the desired system state is expressed as code and converged with Ansible.

The project is also intended as a serious portfolio example of infrastructure engineering applied to scientific computing.

## Conceptual model

```text
hardware / clean OS
        ↓
bootstrap readiness layer
        ↓
Ansible orchestration
        ↓
modular roles
        ↓
verified scientific environment
```

The Bash bootstrap prepares the host for Ansible; it should not become a second configuration-management system.

Ansible owns provisioning.

## Development philosophy

Prefer:

1. one clear capability per role;
2. defaults for configurable values;
3. explicit installation and verification;
4. idempotent Ansible modules over unconditional shell commands;
5. small pull requests;
6. validation before merge;
7. documentation updates when behavior changes.

For a role with enough complexity, the preferred internal lifecycle is:

```text
defaults
→ install
→ configure
→ verify
```

Small roles do not need artificial file splitting.

## Role ordering

Role order in `playbooks/workstation.yml` is meaningful because later tools may depend on earlier system capabilities.

Do not reorder roles casually.

The current playbook contains:

```text
apt
→ common
→ ansible
→ r
→ conda
→ java
→ docker
→ nextflow
→ vscode
→ shell
→ obsidian
→ godot
→ syncthing
→ libresprite
```

## Idempotence

Idempotence is a core acceptance criterion, not an optional polish step.

A feature is not finished merely because the first provisioning run succeeds.

Where feasible, the expected second run is:

```text
changed=0
unreachable=0
failed=0
```

When a task cannot be perfectly idempotent, the reason should be explicit.

## Clean-machine testing

Clean-machine testing is especially valuable for Ocelotl because an already-configured development computer can hide undeclared dependencies.

When validating a fresh Ubuntu machine, do not manually install dependencies that Ocelotl is supposed to manage.

Unexpected missing dependencies should be treated as project defects or undeclared prerequisites.

## Current scope boundary

Ocelotl is currently a local Ubuntu workstation project.

Do not present future ideas as already supported.

In particular, macOS, HPC, cloud profiles, CUDA/NVIDIA automation, Apptainer/Singularity, and named domain-specific Conda environments remain future work unless `main` changes.

## Roadmap

### NOW — synchronization and maintenance

1. Fix the root README release-version inconsistency.
2. Synchronize `docs/architecture.md` with the actual role list by including `libresprite`.
3. Confirm current CI status after documentation cleanup.
4. Keep role READMEs synchronized with role behavior.

### NEXT — engineering maturity

Choose one coherent engineering milestone rather than many unrelated additions.

Strong candidates already aligned with the existing roadmap include:

- Git configuration role;
- automated testing across multiple supported Ubuntu versions;
- named bioinformatics Conda environments;
- additional quality/lint checks where justified.

Selection should be based on current need and existing issues/roadmap, not feature count.

### LATER — broader platform capabilities

Potential later directions:

- Apptainer / Singularity;
- CUDA / NVIDIA tooling;
- HPC / SLURM profiles;
- cloud profiles;
- optional workstation profiles;
- additional scientific CLI tools.

These should not dilute the current goal of a reliable local workstation.

## Release discipline

The changelog separates tagged releases from `Unreleased`.

When preparing a new release:

- confirm implementation state;
- confirm CI/idempotence;
- update changelog;
- synchronize README version references;
- create the tag/release only when explicitly approved.

Do not infer release state from a single badge or stale document.

## Definition of success

Ocelotl is successful when a user can:

1. start from a supported clean Ubuntu workstation;
2. clone the repository;
3. run `./bootstrap.sh`;
4. complete provisioning without manually reconstructing each component;
5. rerun provisioning safely with convergence;
6. begin scientific work with the documented tooling available.
