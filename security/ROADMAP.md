# Security implementation roadmap

**State:** Planning only. Checkboxes indicate work to do, not controls already implemented. All work begins in the clean development Ubuntu installation.

## P0 — Preserve and observe

- [ ] Identify Ubuntu version, kernel, disks, mounts, encryption and network listeners on both machines.
- [ ] Inventory scientific raw data, project repos, SSH access, credentials, and irreplaceable files **without collecting secrets in reports**.
- [ ] Create two independent protected backups of irreplaceable data; perform a sample restore and verify checksums.
- [ ] Determine which data are institutionally restricted; exclude those from uncontrolled sync, GitHub and personal cloud backups.
- [ ] Capture current Ansible role behavior and establish a rollback/recovery procedure.

**Gate:** no disk formatting or production deployment until restoration is independently verified.

## P1 — Minimal bootstrap and identity

- [ ] Split provisioning into opt-in `base`, `security`, `development` and `research` profiles (exact names subject to review).
- [ ] Implement Git user.name/user.email separately from login credentials.
- [ ] Add documented GitHub CLI browser login or per-host SSH key enrolment.
- [ ] Design private config delivery from temporarily mounted LUKS USB, with strict modes, validation and cleanup.
- [ ] Add safe defaults when the USB is absent; never solicit/store account passwords in Ocelotl.
- [ ] Extend `.gitignore`, introduce secret scanning and review history for accidental exposure.

**Gate:** bootstrap succeeds from clean Ubuntu without secrets committed, and can rerun without unexpected changes.

## P2 — Baseline hardening (opt-in)

- [ ] Define policy for package updates and `unattended-upgrades`.
- [ ] Define UFW/nftables baseline based on actual services, with local console fallback.
- [ ] Install/configure SSH only if requested; evaluate effective server config and access needs.
- [ ] Evaluate AppArmor status and available profiles.
- [ ] Make automatic Docker-group membership opt-in; document privileged Docker access and rootless alternative.
- [ ] Make Syncthing installation/service activation opt-in and allowlist synchronized paths.
- [ ] Plan LUKS2 at fresh OS installation; prohibit any automatic destructive storage operations.
- [ ] Use Ansible `no_log` for secret-handling tasks; add config validation before sensitive changes.

**Gate:** safe check-mode review, tested local VM deployment, no lockout or unexpectedly exposed service.

## P3 — Sentinel integration

- [ ] Define machine-readable expected-state policies (no secrets) with host profiles.
- [ ] Implement read-only checks for firewall, listening sockets, updates, SSH, sudo/Docker membership and encryption visibility.
- [ ] Produce JSON and human-readable reports, with evidence, severity, and `unknown/not-applicable` states.
- [ ] Test detections against deliberate non-destructive configuration drift in a VM.
- [ ] Keep Sentinel's audit result separate from Ocelotl's remediation; require explicit consent for changes.

**Gate:** each policy has a reproducible passing and failing test; no Sentinel mutation of host state.

## P4 — Scientific supply chain and integrity

- [ ] Inventory workflow versions, container image digests, Conda envs and external channels.
- [ ] Review pinned versions, checksums and token exposure in Nextflow/nf-core, Docker and GitHub Actions.
- [ ] Verify sample FASTQ and analysis input hashes; preserve provenance and storage permissions.
- [ ] Add tests showing a modified dummy input is detected.
- [ ] Document exclusion of restricted sequencing datasets from personal sync or public services.

## P5 — Rebuild scientific workstation

- [ ] Document disk identity and data placement before shutdown.
- [ ] Disconnect unnecessary data disks during Ubuntu installation.
- [ ] Install a supported Ubuntu release with LUKS encryption; save recovery material offline.
- [ ] Restore data volumes in controlled sequence; validate restoration.
- [ ] Run Ocelotl base, security, development and research profiles.
- [ ] Run Sentinel and representative Nextflow/R scientific workflows.
- [ ] Confirm second provisioning run is idempotent and backup/restore remains functional.

**Final gate:** do not erase the original working environment or last viable backup until checks complete.

## Immediate next change request

Review `roles/git/tasks/main.yml`, `roles/docker/tasks/configure.yml`, `roles/syncthing/tasks/main.yml`, and `playbooks/workstation.yml`. Prepare a separate pull request for opt-in security profiles and non-destructive tests. Do not combine hardening changes with storage formatting.
