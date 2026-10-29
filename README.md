# Ocelotl 🐆

[![Quick CI](https://github.com/erickdelgadillo/ocelotl/actions/workflows/ansible-ci.yml/badge.svg)](https://github.com/erickdelgadillo/ocelotl/actions/workflows/ansible-ci.yml) [![License: MIT](https://img.shields.io/badge/license-MIT-green)](LICENSE)

Reproducible Ubuntu workstation provisioning for bioinformatics, research, and development with Ansible.

**Requirements:** Ubuntu 22.04, 24.04 or 26.04 LTS; `sudo` access. The full workstation profile targets x86_64/amd64.

## Install

```bash
git clone https://github.com/erickdelgadillo/ocelotl.git
cd ocelotl
./bootstrap.sh              # full workstation
```

Use `./bootstrap.sh --help` for options. Individual profiles:

| Profile | Command | Purpose |
| --- | --- | --- |
| Base | `./bootstrap.sh base` | Core tools and Ansible |
| Development | `./bootstrap.sh development` | Editor and shell |
| Bioinformatics | `./bootstrap.sh bioinformatics` | R, Conda, Java, Docker, Nextflow |
| Desktop | `./bootstrap.sh desktop` | Desktop applications |
| AI | `./bootstrap.sh ai` | Ollama and AI application launchers |
| Security | `./bootstrap.sh security` | VeraCrypt, KeePassXC, Bitwarden |
| Full | `./bootstrap.sh full` | Complete workstation |

**Important:** In `full`, optional AI provisioning requires `OCELOTL_ENABLE_AI=1`; downloading an Ollama model additionally requires `OCELOTL_PULL_MODEL=1`. ChatGPT and Perplexity are web launchers, not native Linux apps. The security profile installs applications; it does **not** harden the operating system, encrypt disks or synchronize USB drives. Docker group membership grants root-equivalent privileges.

## Validation

Quick CI checks syntax, lint and shell regressions. Full provisioning CI is manually triggered and checks repeatability (`changed=0` on the second run); it does not verify optional AI/model downloads or all security application downloads on real hardware.

See [profiles](playbooks/profiles/README.md), [roles](roles/README.md), [architecture](docs/architecture.md), [security](security/README.md) and [CHANGELOG](CHANGELOG).

**Latest tag:** `v1.2.0` (GitHub Release publication is separate). **License:** [MIT](LICENSE).
