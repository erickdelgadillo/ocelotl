# Ansible roles

Each role manages one workstation capability. The playbooks define which roles execute and in what order.

Core/scientific roles include `apt`, `common`, `ansible`, `r`, `conda`, `java`, `docker` and `nextflow`. Desktop and optional roles include `vscode`, `shell`, `obsidian`, `godot`, `libresprite`, `security_tools`, `ollama` and `ai_apps`.

The `git` role remains a placeholder; Git is installed by other roles.

## Conventions

- Prefer Ansible modules and idempotent tasks.
- Keep configurable values in `defaults/main.yml`; do not commit secrets.
- Use `become` only when necessary and verify installed state without changes.

## Check

```bash
ansible-playbook --syntax-check playbooks/workstation.yml
ansible-lint
```

After provisioning changes, run the relevant playbook twice; the second run should report `changed=0`. See [architecture](../docs/architecture.md).
