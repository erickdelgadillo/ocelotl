# Security — Ocelotl

> Security architecture, policies, and rollout plan for reproducible Ubuntu bioinformatics workstations.

**Status:** Security tooling implemented; host-hardening controls remain design / documentation only.

## Purpose and boundaries

Ocelotl **configures** systems; Sentinel **audits** their effective state; SPECTRA **organizes** systems, projects and policy ownership. This directory records the security baseline, decisions, rollout stages, and acceptance criteria. It is **not** a repository for credentials, recovery keys, scientific datasets, or machine-specific private configuration.

Targets: locally administered Ubuntu workstations, initially the clean development machine; later the scientific workstation after independently verified backups. The `security_tools` role installs selected user-facing security applications. Hardening changes remain separate and are not implied by installing these tools.

## Existing repository review (2026-10-22)

Reviewed: `bootstrap.sh`, `playbooks/workstation.yml`, `roles/git/tasks/main.yml`, `roles/docker/tasks/configure.yml`, `roles/syncthing/tasks/main.yml`, `.gitignore`, `.github/workflows/ansible-ci.yml`, and architecture documentation.

- Bootstrap verifies OS, sudo, Internet, Git and curl. A dedicated `security` profile now installs the approved security tooling.
- `playbooks/workstation.yml` installs scientific and desktop roles in one run; a dedicated hardening role is absent.
- `roles/git/tasks/main.yml` is empty. Identity and authentication need deliberate, separate implementation.
- Docker role adds the user to the `docker` group. Membership can effectively provide root-level access: make opt-in, document the tradeoff, investigate rootless Docker where feasible.
- Syncthing provisioning has been removed from Ocelotl by decision; synchronization is not a backup. Do not reintroduce automatic file synchronization without a separate design and review.
- CI tests Ansible syntax, lint and a second provisioning run with `changed=0`. Extend it with security tests and isolated development deployment.
- `.gitignore` excludes `.env` but is not a secret-leak prevention control. Extend exclusions and add secret scanning. Keep credentials out of Git history altogether.

These are repository findings, **not** claims about the current hardening state of either machine.

## Security principles

1. **Recovery before reinstallation:** inventory disks, confirm backups with test restores, and retain a separate offline recovery copy before formatting anything.
2. **Least privilege:** use regular accounts; escalate with sudo only for defined tasks; avoid routine Docker group membership.
3. **Secrets never in source control:** no passwords, PATs, SSH private keys, TOTP seeds, LUKS recovery material, or unencrypted Ansible inventories in GitHub.
4. **Separate public configuration from private provisioning:** use per-machine SSH keys and GitHub's browser/device or SSH authentication; Ocelotl does not request the GitHub account password.
5. **Encrypt at rest:** plan LUKS2 at OS installation and separately for data volumes; store recovery information in at least two physically independent protected locations.
6. **Fail safely:** unknown hosts or missing required private settings must stop sensitive tasks; never bypass safety checks to complete a playbook.
7. **Audit without changing:** Sentinel should start as a read-only, explainable auditor; remediation is an explicit Ocelotl action.
8. **Scientific data integrity:** protect RAW sequencing files, results, workflow definitions, metadata, and provenance; use hashes and immutable or versioned backups as appropriate.
9. **Test before deploy:** use the clean Ubuntu system and/or VM first; release to the scientific workstation only after acceptance criteria pass.

## Intended structure

```text
security/
├── README.md         # Scope, architecture, policies and limits
└── ROADMAP.md        # Prioritized tasks, tests and rollout gates
```

**Implemented:**\n- `../roles/security_tools/` — VeraCrypt, KeePassXC and Bitwarden Desktop; no credentials or vault contents are managed.\n- `../playbooks/security.yml` — explicitly invokable with `./bootstrap.sh security`.\n- The full workstation profile includes `security_tools`.\n- FreeFileSync remains a manual installation and is not managed by Ocelotl.\n\n**Future candidates (not implemented):**
- `policies/` — versioned, non-secret policy YAML for Ocelotl and Sentinel
- `tests/` — read-only acceptance tests and isolated VM checks
- `examples/` — redacted sample local configuration
- `../roles/security_base/` — opt-in Ansible hardening role
- `../playbooks/security.yml` — explicitly invoked security playbook

Keep role implementations under `roles/`, not duplicated within `security/`.

## Secret handling design

- Git author name/email are **not credentials**.
- Bootstrap may ask for non-secret preferences or the location of a mounted encrypted provisioning volume.
- Authenticate GitHub using per-host SSH keys or an interactive trusted GitHub CLI login; never ask for or log the GitHub password.
- Ansible Vault may encrypt values that are strictly required for provisioning; encryption at rest does not prevent exposure during runtime. Use `no_log: true` where appropriate and limit file permissions and secret lifetimes.
- An encrypted USB is a temporary source of protected provisioning/recovery material, **not** a single point of failure. Maintain an independent backup. Do not assume that unmounting a USB erases secrets copied into the local OS.
- Avoid passing secrets via shell arguments, environment variables that may leak into logs, or ordinary terminal history. Do not hardcode unlock passphrases.

## Proposed baseline checks

| Domain | Ocelotl desired-state work | Sentinel read-only evidence |
|---|---|---|
| Disk encryption | Document LUKS provisioning and mount policy | Detect mapped encrypted volumes; distinguish unavailable evidence from noncompliance |
| Updates | Configure Ubuntu security updates | Inspect apt timers and unattended-upgrades state |
| Host firewall | Define explicit inbound policy | Inspect nftables/ufw effective rules and listening ports |
| SSH | Install only when needed; key-based login and scoped access | Check effective sshd configuration if installed |
| Accounts | Least-privilege users and directory permissions | Review sudo access, permissions, and risky group membership |
| Containers | Review Docker group, socket exposure and image provenance | Detect root-equivalent membership and insecure container settings |
| File integrity | Hash sample datasets, track provenance | Verify declared SHA-256 manifests without changing source files |
| Backups | Specify offline encrypted backups and restoration drill | Record evidence of actual test restores, not only configured jobs |

Policies must be adapted to whether SSH/Docker are truly required. Do not blindly turn services off or change firewall defaults on remote machines.

## Rollout approach

1. Inventory current hardware/storage, backups, current repository state.
2. Use installation profiles (`base`, `security`, and others) to stage provisioning rather than requiring the full workstation playbook for every change.
3. Define policy schema and local encrypted secret delivery.
4. Add security baseline role with check-mode support where possible.
5. Implement basic Sentinel checks as a **separate project**.
6. Add automated tests, dry runs, VM verification, and manual restore drills.
7. Apply to the clean development Ubuntu machine.
8. Only after verification, back up and rebuild the scientific workstation with encrypted volumes.

See [ROADMAP.md](ROADMAP.md) for actionable checkpoints.

## Non-goals

- No offensive payloads, scanning third-party infrastructure, or remote management without explicit authorization.
- No automatic destructive disk formatting via Ansible.
- No promise that a passing check proves the machine cannot be compromised.
- No plaintext or encrypted personal secrets committed to this public repository. Even encrypted credentials should normally remain outside source control.

## References

- [Ubuntu security documentation](https://documentation.ubuntu.com/security/)
- [Ansible Vault](https://docs.ansible.com/ansible/latest/vault_guide/)
- [Docker daemon attack surface](https://docs.docker.com/engine/security/)
- [GitHub SSH authentication](https://docs.github.com/en/authentication/connecting-to-github-with-ssh)
