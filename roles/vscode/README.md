# Visual Studio Code role

Installs Visual Studio Code from Microsoft's APT repository and manages a
baseline set of extensions for Nextflow, YAML, and Ansible development.

## Responsibilities

The role:

- Installs the APT prerequisites `wget`, `gpg`, and `apt-transport-https`.
- Downloads Microsoft's package signing key.
- Converts the key to a GPG keyring at
  `/usr/share/keyrings/packages.microsoft.gpg`.
- Configures the Microsoft Visual Studio Code APT repository.
- Installs the `code` package.
- Lists installed VS Code extensions for the target user.
- Installs any configured extensions that are not already present.

## Default variables

| Variable | Default | Description |
| --- | --- | --- |
| `vscode_extensions` | See below | Extensions installed for the Ansible target user. |

The default extension list is:

```yaml
vscode_extensions:
  - nextflow.nextflow
  - MichaelCBrazell.nextflow-sandbox-2
  - redhat.vscode-yaml
  - redhat.ansible
```

Extension identifiers are compared case-insensitively with the output of
`code --list-extensions`, so extensions that are already installed are not
installed again.

## Example playbook

```yaml
---
- name: Install Visual Studio Code tools
  hosts: localhost
  connection: local
  become: false

  roles:
    - role: vscode
```

Customize the extension set through variables:

```yaml
vscode_extensions:
  - nextflow.nextflow
  - redhat.vscode-yaml
  - redhat.ansible
```

The role installs system packages with privilege escalation, but it executes
the `code --list-extensions` and `code --install-extension` commands without
privilege escalation. Therefore, extensions are installed for the Ansible
target user, not for root.

## Validation

After the role completes, verify the executable and installed extensions:

```bash
code --version
code --list-extensions
```

To confirm the managed extensions specifically:

```bash
code --list-extensions | grep -Ei \
  '^(nextflow\.nextflow|michaelcbrazell\.nextflow-sandbox-2|redhat\.vscode-yaml|redhat\.ansible)$'
```

## Notes

The Microsoft repository definition supports the `amd64`, `arm64`, and `armhf`
architectures. The role installs the stable `code` package.

The signing key is downloaded first to `/tmp/microsoft.asc`, then converted to
a GPG keyring. The conversion command uses Ansible's `creates` guard, so it
does not overwrite an existing keyring automatically.

## Idempotence

The role uses Ansible modules to manage APT prerequisites, repository
configuration, and the VS Code package. For extensions, it first inventories
the user's current extension list and only runs installation commands for
missing identifiers. Re-running the role should therefore avoid reinstalling
already present extensions.
