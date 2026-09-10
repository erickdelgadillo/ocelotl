# Ocelotl Bootstrap Library

The `lib/` directory contains the internal Bash library used by Ocelotl's bootstrap process.

Its purpose is to prepare and validate the minimum environment required to start Ansible. Once Ansible is available, workstation provisioning is delegated to the roles and playbooks under `roles/` and `playbooks/`.

`lib/` is therefore part of the **bootstrap layer**, not the main provisioning layer.

## Responsibilities

The bootstrap library is responsible for:

- validating the host operating system;
- checking administrative privileges;
- verifying Internet connectivity;
- checking bootstrap dependencies such as Git and curl;
- ensuring Ansible Core is available;
- installing Ansible Core when necessary;
- launching the main workstation playbook;
- providing consistent bootstrap logging.

Application installation and workstation configuration should normally be implemented in Ansible roles rather than in this directory.

## Structure

```text
lib/
├── checks/
│   ├── ansible.sh
│   ├── curl.sh
│   ├── git.sh
│   ├── internet.sh
│   ├── os.sh
│   └── sudo.sh
├── configuration/
├── core/
│   └── ansible.sh
├── installers/
│   └── ansible.sh
├── verification/
├── init.sh
└── logging.sh
```

Some directories currently contain only `.gitkeep` placeholders. They reserve the structure for future bootstrap functionality and should not be interpreted as implemented components.

## Components

### `logging.sh`

Provides the common logging interface used by the bootstrap scripts:

- `log_info`
- `log_success`
- `log_warning`
- `log_error`

Bootstrap modules should use these functions instead of implementing their own output formatting.

### `checks/`

Contains environment and dependency checks required before provisioning can begin.

Current checks include:

| Module | Responsibility |
| --- | --- |
| `os.sh` | Verifies that the host is a supported Ubuntu release |
| `sudo.sh` | Verifies that `sudo` exists and administrative privileges are available |
| `internet.sh` | Tests connectivity against configured external endpoints |
| `git.sh` | Verifies Git availability and reports its version |
| `curl.sh` | Verifies curl availability and reports its version |
| `ansible.sh` | Verifies Ansible Core availability and reports its version |

Checks should detect and report system state. They should not perform workstation provisioning.

### `installers/`

Contains installation logic required specifically to bootstrap Ocelotl.

Currently, `installers/ansible.sh` installs Ansible Core through Ubuntu's APT repositories when Ansible is not already available.

This directory should remain intentionally small. Software that can be installed after Ansible becomes available belongs in an Ansible role.

### `core/`

Contains orchestration logic connecting bootstrap checks, installers, and Ansible.

`core/ansible.sh` currently provides:

- `ensure_ansible`, which verifies Ansible, installs it if necessary, and verifies the resulting installation;
- `run_workstation_playbook`, which launches the main Ocelotl workstation playbook.

When available, `run_workstation_playbook` uses `sudo.ws` as the Ansible privilege-escalation executable; otherwise it falls back to `sudo`.

### `configuration/`

Reserved for future bootstrap-level configuration logic.

Configuration that belongs to provisioned applications should remain inside the corresponding Ansible role.

### `verification/`

Reserved for future bootstrap-level verification logic.

Application and tool verification should normally be implemented by the corresponding Ansible role.

## Loading Order

`lib/init.sh` is the entry point for the internal Bash library.

Modules are currently loaded in the following order:

```text
logging.sh
    ↓
checks/os.sh
checks/sudo.sh
checks/internet.sh
checks/git.sh
checks/curl.sh
checks/ansible.sh
    ↓
installers/ansible.sh
    ↓
core/ansible.sh
```

This order ensures that shared logging and dependency functions are available before higher-level orchestration functions use them.

New modules that depend on existing functions must be sourced after those dependencies in `init.sh`.

## Bash vs. Ansible

Ocelotl deliberately keeps the Bash bootstrap layer small.

Use **Bash in `lib/`** when the logic is required before Ansible can run, for example:

- validating whether the host can run Ocelotl;
- checking bootstrap dependencies;
- obtaining administrative privileges;
- installing Ansible itself;
- starting the Ansible playbook.

Use **Ansible roles** for workstation provisioning, including:

- installing development tools;
- configuring applications;
- managing repositories and packages;
- creating configuration files;
- enabling services;
- verifying provisioned software.

A useful rule is:

> If the operation can safely wait until Ansible is available, it probably belongs in an Ansible role.

This separation prevents bootstrap logic from duplicating Ansible functionality and keeps provisioning declarative and idempotent.

## Adding Bootstrap Logic

Before adding a new module to `lib/`:

1. Confirm that the functionality is required before Ansible can run.
2. Place detection logic in `checks/`.
3. Place unavoidable bootstrap installation logic in `installers/`.
4. Keep orchestration logic in `core/`.
5. Use the shared logging functions from `logging.sh`.
6. Source the new module from `init.sh` in dependency order.
7. Return non-zero status codes when an operation cannot complete successfully.

Do not add general workstation software installers to `lib/`. Those belong in `roles/`.

## Design Principle

The bootstrap layer should do only enough work to reach a state where Ansible can take over.

In simplified form:

```text
bootstrap.sh
     │
     ▼
   lib/
     │
     ├── validate environment
     ├── validate bootstrap dependencies
     ├── ensure Ansible
     │
     ▼
Ansible playbook
     │
     ▼
   roles/
     │
     ▼
configured workstation
```

Keeping this boundary explicit makes Ocelotl easier to maintain, test, and extend without maintaining two competing provisioning systems.
