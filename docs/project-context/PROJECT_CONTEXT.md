# Ocelotl — Project Context

## Why this project exists

Ocelotl treats a scientific workstation as reproducible infrastructure.

Instead of manually rebuilding a bioinformatics environment after reinstalls, hardware changes, or system upgrades, the desired workstation state is expressed as code and converged with Ansible.

The project is also a portfolio example of infrastructure engineering applied to scientific computing.

## Conceptual architecture

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

## Development principles

Prefer:

1. one clear capability per role;
2. defaults for configurable values;
3. explicit installation and verification;
4. idempotent Ansible modules over unconditional shell commands;
5. small pull requests;
6. validation before merge;
7. documentation updates when behavior changes.

For sufficiently complex roles, the preferred lifecycle is:

```text
defaults
→ install
→ configure
→ verify
```

Small roles do not need artificial file splitting.

## Role ordering

Role order in `playbooks/workstation.yml` is meaningful because later components may depend on earlier system capabilities.

Current order:

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

Do not reorder roles casually.

## Idempotence

Idempotence is a core acceptance criterion.

A first successful run proves installation behavior.

A second run should ideally produce:

```text
changed=0
unreachable=0
failed=0
```

If a task cannot be perfectly idempotent, the reason should be explicit.

## Clean-machine testing

Clean-machine testing matters because an already-configured development machine can hide undeclared dependencies.

When validating a fresh Ubuntu system, do not manually install dependencies that Ocelotl is supposed to manage.

Unexpected missing dependencies should be treated as project defects or explicit prerequisites.

## Scope boundary

Ocelotl is currently a local Ubuntu workstation project.

Do not present future ideas as supported capabilities.

macOS, HPC, cloud profiles, CUDA/NVIDIA automation, Apptainer/Singularity, and named domain-specific Conda environments remain future work unless current `main` implements them.

## Security boundaries

Ocelotl should not:

- store passwords, API keys, tokens, or SSH private keys;
- run the entire repository as root;
- silently modify unrelated user files;
- install GPU drivers automatically;
- hide privilege escalation or destructive changes.

## Source of truth

For implementation details, current GitHub `main` overrides this file.
