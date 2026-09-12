# Common role

Installs a baseline set of Ubuntu packages used across Ocelotl workstation
profiles.

This role provides general development, networking, command-line, and
file-management utilities. It is intended to run early in a workstation
provisioning workflow so that later roles can rely on common tools being
available.

## Installed packages

The role installs the following packages through APT:

| Category | Packages |
| --- | --- |
| Build tools | `build-essential` |
| Certificates and security | `ca-certificates`, `gnupg` |
| Network and downloads | `curl`, `wget` |
| Version control | `git` |
| System and data utilities | `htop`, `jq`, `rsync`, `tree` |
| Repository support | `software-properties-common` |
| Archive utilities | `unzip`, `zip` |

## Example playbook

```yaml
---
- name: Provision common workstation tools
  hosts: localhost
  connection: local

  roles:
    - role: common
```

The package list is currently defined directly in
[`tasks/main.yml`](tasks/main.yml). Add broadly useful baseline packages there
only when they are required across multiple workstation profiles or roles.

## Validation

After running the role, confirm that representative commands are available:

```bash
git --version
curl --version
jq --version
htop --version
```

For package-level verification:

```bash
dpkg-query -W build-essential ca-certificates curl git gnupg htop jq rsync \
  software-properties-common tree unzip wget zip
```

## Idempotence

The role uses `ansible.builtin.apt` with `state: present`. Re-running it should
not reinstall packages that are already present.
