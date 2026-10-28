# Installation profiles

| Profile | Playbook | Main purpose |
| --- | --- | --- |
| Base | `base.yml` | Core packages and Ansible |
| Development | `development.yml` | Editor and shell |
| Bioinformatics | `bioinformatics.yml` | R, Conda, Java, Docker, Nextflow |
| Desktop | `desktop.yml` | Desktop tools |
| AI | `ai.yml` | Ollama and AI apps |
| Security | `security.yml` | VeraCrypt, KeePassXC, Bitwarden |
| Full | `workstation.yml` | Workstation stack |

From the repository root, use `./bootstrap.sh <profile>`; without an argument it runs `full`. Check `./bootstrap.sh --help`.

**Caveats:** The security profile installs tools, not OS hardening. The Docker group is root-equivalent. Full-profile AI/model downloads are opt-in; see the [main README](../../README.md). Profiles do not format disks, encrypt volumes, or manage secrets.
