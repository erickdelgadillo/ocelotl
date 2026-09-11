# Ansible inventory

This directory contains Ansible inventory files used by Ocelotl.

An inventory defines the hosts that Ansible manages and, when necessary,
connection settings associated with those hosts. Ocelotl is primarily designed
to provision the machine on which it is executed, so the default inventory is
intentionally small and local.

## Included inventory

| File | Purpose |
| --- | --- |
| [localhost.ini](localhost.ini) | Defines the local workstation target used by the project playbooks. |

Use the inventory explicitly when running a playbook:

```bash
ansible-playbook -i inventory/localhost.ini playbooks/workstation.yml
```

For the R-focused workflow:

```bash
ansible-playbook -i inventory/localhost.ini playbooks/r.yml
```

Run commands from the repository root so that Ansible can resolve
`ansible.cfg`, roles, playbooks, and relative paths consistently.

## Local provisioning

The default local inventory is the preferred entry point for a workstation
installation. Before running a playbook, verify that Ansible can reach the
target:

```bash
ansible -i inventory/localhost.ini all -m ping
```

Use Ansible's dry-run mode before applying a new or modified configuration:

```bash
ansible-playbook -i inventory/localhost.ini playbooks/workstation.yml --check --diff
```

A successful check is useful but is not a substitute for testing a full
provisioning run. Some installation tasks require real changes before their
final state can be verified.

## Additional inventories

You may create separate inventories for other machines, test systems, or
deployment scenarios. Keep local or environment-specific inventories outside
version control unless they contain only safe, reusable example values.

For example, a private inventory could be placed in a locally ignored path:

```text
inventory/local/
├── development.ini
└── testing.ini
```

Pass it explicitly when running Ansible:

```bash
ansible-playbook -i inventory/local/development.ini playbooks/workstation.yml
```

If the project later needs reusable shared examples, add a sanitized template
such as `example.ini` to version control and document every variable it
contains.

## Security and privacy

Do not commit inventories that contain private or sensitive information,
including:

- Real user names, hostnames, IP addresses, or internal DNS names.
- SSH private keys, passwords, vault passwords, access tokens, or API keys.
- Personal paths, institutional infrastructure details, or credentials passed
  through host variables.
- Environment-specific configuration that cannot safely be made public.

Use Ansible Vault or another dedicated secret-management mechanism for secrets.
Do not store secret material directly in inventory files, playbooks, role
defaults, or documentation examples.

## Related documentation

- [Repository README](../README.md): installation overview and project entry
  points.
- [Playbooks README](../playbooks/README.md): available provisioning workflows.
- [Architecture documentation](../docs/architecture.md): component boundaries
  and repository design.
