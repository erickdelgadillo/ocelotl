# Ocelotl installation profiles

Profiles compose **existing** Ansible roles. They do not duplicate role code.

| Profile | Playbook | Includes |
|---|---|---|
| Base | `playbooks/base.yml` | apt, common, ansible |
| Development | `playbooks/development.yml` | base plus VS Code and shell |
| Bioinformatics | `playbooks/bioinformatics.yml` | base packages, R, Conda, Java, Docker, Nextflow |
| Desktop | `playbooks/desktop.yml` | optional desktop applications |
| Full | `playbooks/workstation.yml` | existing full workstation profile, without Syncthing |

**Security profile is not implemented yet.** See `security/README.md`. A secure Ubuntu installation requires additional host-specific decisions and verification.

Run from the repository root:

```bash
ansible-playbook -i inventory/localhost.ini playbooks/base.yml --ask-become-pass
ansible-playbook -i inventory/localhost.ini playbooks/bioinformatics.yml --ask-become-pass
```

For the standard launcher, `./bootstrap.sh base` or `./bootstrap.sh bioinformatics` selects a profile; no argument continues to mean the historical `full` profile. Use `./bootstrap.sh --help` for options.

**Important:** Docker role currently grants the invoking user membership of the `docker` group, which effectively grants root-level access. Review before running bioinformatics/full. Do not run these on the production workstation until evaluated on the clean test Ubuntu. Profiles do not erase data, encrypt disks, transfer scientific datasets, or set up GitHub authentication.

`base` is the first validation target. `development`, `bioinformatics` and `desktop` may be run separately or sequentially; a role reused in multiple profiles should be idempotent. Test a second execution and confirm no unexpected changes.
