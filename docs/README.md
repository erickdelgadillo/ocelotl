# Documentation

This directory contains the project documentation for Ocelotl.

Ocelotl provisions reproducible Ubuntu workstations for scientific computing,
bioinformatics, data analysis, and development. The documentation complements
the repository-level [README](../README.md): use the root README for a quick
start, and use the documents in this directory when you need implementation
details, design context, or guidance for extending the project.

## Contents

| Document | Description |
| --- | --- |
| [architecture.md](architecture.md) | Overview of the repository structure, provisioning flow, Ansible components, and configuration boundaries. |

## Recommended reading path

1. Start with the repository-level [README](../README.md) to understand the
   project scope and the basic installation workflow.
2. Read [architecture.md](architecture.md) before changing playbooks, roles,
   shared shell libraries, or configuration conventions.
3. Review the documentation in the relevant component directory:
   [playbooks](../playbooks/README.md), [inventory](../inventory/README.md),
   [roles](../roles/README.md), or [lib](../lib/README.md).
4. Inspect the role source directly when you need the exact defaults, tasks,
   dependencies, or tags that apply to a component.

## Documentation principles

Documentation in Ocelotl should:

- Describe the purpose, interfaces, and expected behaviour of each component.
- Keep executable configuration as the source of truth; avoid duplicating long
  package lists or variable values that are maintained in Ansible files.
- Use relative links so documentation remains useful in a local clone and on
  GitHub.
- Clearly distinguish public defaults from machine-specific values and secrets.
- Include safe, reproducible examples that do not expose user names, hostnames,
  credentials, SSH keys, tokens, or private paths.
- State validation steps whenever a document describes a change in behaviour.

## Keeping documentation current

Update the relevant documentation when a change affects:

- The provisioning entry points or installation sequence.
- The role layout, shared library conventions, or configuration model.
- Supported Ubuntu versions or other compatibility assumptions.
- User-facing variables, profiles, tags, or command-line examples.
- Required validation, troubleshooting, or recovery steps.

For implementation conventions and the relationship among bootstrap scripts,
playbooks, roles, and shared shell functions, see
[architecture.md](architecture.md).
