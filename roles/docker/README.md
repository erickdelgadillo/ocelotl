# Docker role

Installs and configures Docker Engine on Ubuntu using Docker's official APT
repository.

The role installs the Docker command-line client, Docker Engine, containerd,
Buildx, and the Docker Compose plugin. It enables the Docker socket and
service, adds the Ansible target user to the `docker` group, and verifies the
CLI, Compose plugin, group membership, and running daemon.

## Responsibilities

The role:

- Creates `/etc/apt/keyrings` when it does not exist.
- Downloads Docker's APT signing key.
- Removes legacy Docker APT source files.
- Configures Docker's official Ubuntu APT repository.
- Installs the configured Docker packages.
- Reloads systemd configuration.
- Enables and starts `docker.socket` and `docker.service`.
- Adds `ansible_user_id` to the configured Docker group.
- Verifies Docker, Docker Compose, and the Docker daemon.

## Default variables

| Variable | Default | Description |
| --- | --- | --- |
| `docker_apt_repository` | `https://download.docker.com/linux/ubuntu` | Base URL for Docker's Ubuntu APT repository. |
| `docker_gpg_key_url` | `{{ docker_apt_repository }}/gpg` | URL of Docker's repository signing key. |
| `docker_gpg_key_path` | `/etc/apt/keyrings/docker.asc` | Local path for the Docker signing key. |
| `docker_packages` | `docker-ce`, `docker-ce-cli`, `containerd.io`, `docker-buildx-plugin`, `docker-compose-plugin` | Docker packages installed through APT. |
| `docker_service_name` | `docker.service` | Docker systemd service name. |
| `docker_socket_name` | `docker.socket` | Docker systemd socket name. |
| `docker_group` | `docker` | Group granted access to the Docker daemon. |
| `docker_apt_sources_path` | `/etc/apt/sources.list.d/docker.sources` | Destination for the Docker deb822 APT source definition. |
| `docker_legacy_apt_sources` | `/etc/apt/sources.list.d/docker.list` | Legacy source files removed before configuring the current repository. |

The role maps common Ansible architecture facts to Docker APT architecture
names through `docker_apt_architecture_map`: `x86_64` maps to `amd64`, and
`aarch64` maps to `arm64`.

## Example playbook

```yaml
---
- name: Provision a local workstation
  hosts: localhost
  connection: local
  become: false

  roles:
    - role: docker
```

Override public variables in inventory, group variables, host variables, or a
dedicated variables file:

```yaml
docker_group: docker
docker_packages:
  - docker-ce
  - docker-ce-cli
  - containerd.io
  - docker-buildx-plugin
  - docker-compose-plugin
```

Do not place credentials, access tokens, or private registry configuration in
role defaults or public inventory files.

## Validation

The role performs the following checks during execution:

```bash
docker --version
docker compose version
sudo docker info --format '{{json .ServerVersion}}'
```

It also asserts that the Ansible target user belongs to the configured Docker
group.

After the playbook completes, open a new login session before running Docker
without `sudo`. Group membership changes do not always take effect in an
existing shell. Then verify access:

```bash
docker run --rm hello-world
```

## Security note

Membership in the `docker` group grants privileges equivalent to root access on
the host. Add only trusted users to this group and review that decision in the
context of the system's security model.

## Idempotence

APT keys, repository configuration, packages, services, and group membership
are managed through idempotent Ansible modules. Re-running the role should not
make changes when Docker is already installed and configured as requested.
