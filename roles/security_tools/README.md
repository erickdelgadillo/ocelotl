# security_tools

Installs the user-facing security tools managed by Ocelotl:

- VeraCrypt
- KeePassXC
- Bitwarden Desktop

The role deliberately does **not** manage passwords, Bitwarden vault contents,
VeraCrypt passwords/keyfiles, recovery codes, TOTP seeds, USB UUIDs, or any
other private material.

FreeFileSync is intentionally not installed by Ocelotl. If desired, install it
manually and configure synchronization outside this role.

## Variables

Each application can be disabled independently:

```yaml
security_tools_veracrypt: true
security_tools_keepassxc: true
security_tools_bitwarden: true
```

VeraCrypt and Bitwarden are pinned to explicit upstream releases. Downloads are
verified before installation. KeePassXC is installed from Ubuntu's configured
APT repositories.

The package cache lives at `/var/cache/ocelotl/security` so repeated runs do
not redownload unchanged installers and remain idempotent.
