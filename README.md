# Ocelotl
![Version](https://img.shields.io/badge/version-v1.0.0-blue)
![Ubuntu](https://img.shields.io/badge/Ubuntu-22.04%2B-E95420)
![Ansible](https://img.shields.io/badge/Ansible-automation-red)
![License](https://img.shields.io/badge/license-MIT-green)


## Hero
> Build a reproducible bioinformatics workstation from a clean Ubuntu installation using Ansible.

## Vision
Every time a researcher joins a new laboratory, they spend hours—or even days—rebuilding the same computational environment.

Ocelotl automates this process through a modular Ansible provisioning framework designed for reproducibility, maintainability, and portability.

## Core Principles

- Reproducible
- Modular
- Maintainable
- Automated
- Documented

## Architecture
```
bootstrap.sh
        │
        ▼
Ansible Playbook
        │
        ▼
Roles
 ├── common
 ├── conda
 ├── java
 ├── docker
 └── nextflow
        │
        ▼
Verified Workstation
```

## Current Features
| Feature                        | Status |
| ------------------------------ | :----: |
| Ubuntu verification            |    ✅   |
| sudo verification              |    ✅   |
| Internet verification          |    ✅   |
| Git verification               |    ✅   |
| curl verification              |    ✅   |
| Automatic Ansible installation |    ✅   |


## Implemented roles
| roles                 | Status |
| --------------------- | :----: |
| apt                   |    ✅   |
| common                |    ✅   |
| conda                 |    ✅   |
| java                  |    ✅   |
| Docker                |    ✅   |
| Nextflow              |    ✅   |

## Planned Roles
| VS Code              |    ⏳   |
| Git configuration    |    ⏳   |
| Shell customization  |    ⏳   |


## Installation
```bash
git clone https://github.com/erickdelgadillo/ocelotl.git

cd ocelotl

./bootstrap.sh
```

## Development Workflow
```
feature branch
        │
        ▼
Pull Request
        │
        ▼
Review
        │
        ▼
Merge
        │
        ▼
main
```


## Future Vision
Ocelotl is intended to evolve into a complete provisioning framework capable of deploying fully reproducible bioinformatics workstations for research laboratories, HPC environments and cloud infrastructures.

## Why Ocelotl?

"Ocelotl" is the Nahuatl word for the ocelot, a wild feline native to the Americas. The name reflects adaptability, precision, and resilience—qualities that also define reproducible scientific computing.