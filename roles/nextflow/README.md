# Nextflow role

Installs the Nextflow launcher and verifies that its command-line interface is
available.

The role downloads a launcher script from a configurable URL, writes it to a
configurable system path with executable permissions, and validates the
installation by running `nextflow -version`.

## Responsibilities

The role:

- Downloads the Nextflow launcher with Ansible's `get_url` module.
- Installs it with mode `0755`.
- Places the launcher at `/usr/local/bin/nextflow` by default.
- Verifies that the command exits successfully and reports the expected
  Nextflow version output.

## Default variables

| Variable | Default | Description |
| --- | --- | --- |
| `nextflow_version` | `latest` | Intended Nextflow version label. |
| `nextflow_download_url` | `https://github.com/nextflow-io/nextflow/releases/latest/download/nextflow` | URL downloaded by the role. |
| `nextflow_install_path` | `/usr/local/bin/nextflow` | Destination path for the executable launcher. |

At present, `nextflow_download_url` determines the installed release. The
default URL points to the upstream `latest` launcher. Override the URL with a
version-pinned release URL when strict reproducibility is required.

## Example playbook

```yaml
---
- name: Install Nextflow
  hosts: localhost
  connection: local
  become: false

  roles:
    - role: nextflow
```

A pinned installation can be configured through variables:

```yaml
nextflow_version: "RELEASE_VERSION"
nextflow_download_url: >-
  https://github.com/nextflow-io/nextflow/releases/download/vRELEASE_VERSION/nextflow
nextflow_install_path: /usr/local/bin/nextflow
```

Replace `RELEASE_VERSION` with the upstream version selected by your project.

## Validation

The role validates the installation with:

```bash
/usr/local/bin/nextflow -version
```

After provisioning, the same check can be run through the command name when
`/usr/local/bin` is on `PATH`:

```bash
nextflow -version
```

The validation expects the output to contain both `N E X T F L O W` and
`version`.

## Reproducibility note

Using the default `latest` URL means the downloaded launcher may change between
runs. For reproducible scientific environments, pin
`nextflow_download_url` to a specific upstream release and record that version
alongside the workflow or profile that depends on it.

## Idempotence

The download is managed by `ansible.builtin.get_url`. Re-running the role
normally leaves the file unchanged when the remote content and destination
already match. A change in the upstream content served by the configured URL,
including `latest`, can update the installed launcher.
