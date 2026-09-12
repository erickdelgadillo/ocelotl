# Git role

This role is currently a placeholder.

The role directory contains `tasks/main.yml`, but it does not define any
Ansible tasks at present. Including the role in a playbook therefore makes no
configuration changes.

## Current status

The role is reserved for future Git-related workstation configuration, such as:

- Installing Git when it is not provided by another role.
- Managing safe, public Git defaults.
- Documenting optional user-managed configuration.
- Providing reusable project-wide Git conventions.

Git itself is currently installed by the
[`common`](../common/README.md) and
[`shell`](../shell/README.md) roles.

## Usage

The role can be referenced in a playbook without side effects:

```yaml
---
- name: Provision a workstation
  hosts: localhost
  connection: local

  roles:
    - role: git
```

## Future development

Before adding tasks to this role:

- Keep user identity, email addresses, signing keys, tokens, credentials, and
  private remotes outside version-controlled defaults.
- Prefer safe, documented defaults over personal configuration.
- Use variables for optional behaviour and provide conservative default values.
- Add validation and idempotence checks with the implementation.
- Update this README with supported variables, managed files, and verification
  commands.
