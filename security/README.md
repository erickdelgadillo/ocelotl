# Security

**Implemented:** `./bootstrap.sh security` installs VeraCrypt, KeePassXC and Bitwarden Desktop through `security_tools`. The full workstation profile also includes these tools.

**Not implemented:** host hardening, disk encryption, automatic USB synchronization, secret provisioning and security auditing. FreeFileSync remains a manual installation.

Never commit passwords, tokens, recovery keys, SSH private keys or personal inventories. Keep encrypted backups in independent locations and verify recovery before reinstalling a machine.

**Risk:** membership in the Docker group effectively grants root-level access.

See [ROADMAP](ROADMAP.md) for proposed hardening, verification and rollout work. Ocelotl configures workstations; installing security applications is not proof of a secure host.
