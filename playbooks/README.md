# Playbooks

Ansible entry points for workstation provisioning.

- [workstation.yml](workstation.yml) — full workstation.
- [r.yml](r.yml) — R-focused installation.
- [Profiles](profiles/README.md) — other supported profiles.

Run from the repository root:

```bash
ansible-playbook -i inventory/localhost.ini playbooks/workstation.yml --ask-become-pass
```

Prefer `./bootstrap.sh <profile>` for normal installation. For details, inspect the playbooks and [roles](../roles/README.md).
