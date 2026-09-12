# Ansible role

Installs and verifies development tooling used to maintain and validate
Ocelotl's Ansible configuration.

At present, the role manages `ansible-lint` through Ubuntu APT.

## Responsibilities

The role:

- Installs every package listed in `ansible_dev_packages`.
- Refreshes the APT package cache when installing the development tools.
- Runs `ansible-lint --version`.
- Reports the installed `ansible-lint` version through Ansible debug output.

## Default variables

| Variable | Default | Description |
| --- | --- | --- |
| `ansible_dev_packages` | `ansible-lint` | APT packages used for Ansible development and validation. |

Extend this list only with broadly useful, supported tooling. Document every
new package and add an explicit validation task when a command-line interface
is expected.

## Example playbook

```yaml
---
- name: Install Ansible development tools
  hosts: localhost
  connection: local

  roles:
    - role: ansible
```

A custom package collection can be set in inventory or a variables file:

```yaml
ansible_dev_packages:
  - ansible-lint
```

Avoid using this role to distribute credentials, vault passwords, private
collections, or machine-specific Ansible configuration.

## Validation

The role checks the installed linter with:

```bash
ansible-lint --version
```

From the repository root, use the linter against the project configuration:

```bash
ansible-lint
```

If the repository uses an Ansible lint configuration file, that configuration
is automatically discovered by `ansible-lint` when invoked from the project
root.

## Idempotence

The role uses `ansible.builtin.apt` with `state: present`. Re-running it should
not reinstall `ansible-lint` when it is already installed.
