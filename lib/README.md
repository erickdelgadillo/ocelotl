# Bootstrap library

Internal Bash helpers used by `bootstrap.sh` **before** Ansible takes over.

- `checks/` — OS, sudo, connectivity and dependency checks.
- `installers/` — bootstrap-only installation of Ansible.
- `core/` — orchestration.
- `logging.sh` — shared logging.
- `init.sh` — module loading.

Install and configure workstation applications in Ansible roles, not here. See [architecture](../docs/architecture.md).
