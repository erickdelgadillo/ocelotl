# APT role

Refreshes the Ubuntu APT package cache for Ocelotl provisioning runs.

This role is intentionally small. It centralizes cache refresh behaviour so
playbooks can prepare package metadata before roles install system packages or
configure additional APT repositories.

## Behaviour

The role runs `ansible.builtin.apt` with:

```yaml
update_cache: true
cache_valid_time: 3600
```

APT metadata is therefore refreshed when the local cache is older than one
hour. A cache that was updated within the preceding 3600 seconds is reused.

## Example playbook

```yaml
---
- name: Refresh package metadata
  hosts: localhost
  connection: local

  roles:
    - role: apt
```

The role requires privilege escalation because updating package metadata changes
system-managed APT state.

## Validation

Check when the package lists were last updated:

```bash
stat /var/lib/apt/periodic/update-success-stamp
```

You can also refresh and inspect the cache manually:

```bash
sudo apt update
```

## Idempotence

The one-hour cache validity period prevents unnecessary refreshes during
repeated provisioning runs. The role may report a change when the cache is
stale and APT metadata must be updated.
