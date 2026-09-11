# Playbooks

This directory contains Ocelotl's top-level Ansible playbooks.

A playbook is an executable provisioning entry point. Each playbook selects and
orchestrates one or more reusable roles from [`../roles`](../roles). Use these
files to apply a defined workstation profile rather than running individual
role task files directly.

## Available playbooks

| Playbook | Intended use |
| --- | --- |
| [workstation.yml](workstation.yml) | Main workstation provisioning workflow. Use it to configure the standard Ocelotl environment and its selected tools. |
| [r.yml](r.yml) | R-focused provisioning workflow. Use it when you need the R environment and its related configuration independently of the broader workstation profile. |

The exact roles, variables, tags, and dependencies are defined in each
playbook and in the roles themselves. Treat those executable files as the
source of truth.

## Prerequisites

Before running a playbook:

1. Use a supported Ubuntu system and run commands from the repository root.
2. Clone the repository and review the root [README](../README.md).
3. Ensure Ansible is installed, either through the documented bootstrap process
   or through your system package manager.
4. Review the selected inventory, normally
   [`../inventory/localhost.ini`](../inventory/localhost.ini).
5. Read the playbook and role defaults before enabling optional tools or
   changing variables.

## Running a playbook

Run the main workstation profile with the local inventory:

```bash
ansible-playbook -i inventory/localhost.ini playbooks/workstation.yml
```

Run the R-focused profile:

```bash
ansible-playbook -i inventory/localhost.ini playbooks/r.yml
```

When provisioning a local system, privilege escalation may be required by
package-management and system-configuration tasks:

```bash
ansible-playbook -i inventory/localhost.ini playbooks/workstation.yml --ask-become-pass
```

Use `--ask-become-pass` only when your local sudo configuration requires it.

## Preview and validation

Preview the intended changes before applying a new configuration:

```bash
ansible-playbook -i inventory/localhost.ini playbooks/workstation.yml --check --diff
```

Inspect the available tags before using tag-limited execution:

```bash
ansible-playbook -i inventory/localhost.ini playbooks/workstation.yml --list-tags
```

List the tasks included by a playbook:

```bash
ansible-playbook -i inventory/localhost.ini playbooks/workstation.yml --list-tasks
```

After a successful provisioning run, re-run the same command to check
idempotence. A well-behaved role should report no unexpected changes on the
second run.

## Customization

Prefer configuration through documented variables, inventory variables, or
dedicated user-managed variable files rather than editing role tasks directly.
This keeps upgrades, reviews, and reproducibility manageable.

Before adding machine-specific configuration:

- Determine whether it is public and broadly reusable.
- Keep personal values, private paths, identity details, and secrets out of
  version-controlled files.
- Add safe defaults and document any new public variable.
- Validate the change with `--check --diff` and a real run where appropriate.
- Re-run the relevant playbook to verify idempotence.

For role-level behaviour and variables, see the
[roles documentation](../roles/README.md). For repository design and execution
flow, see the [architecture documentation](../docs/architecture.md).
