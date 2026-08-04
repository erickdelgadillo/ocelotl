# Mentat-Core

## Hero
> Build a complete, reproducible bioinformatics workstation from a clean Ubuntu installation.

## Vision
Every time a researcher joins a new laboratory, they spend hours or days rebuilding the same computational environment. Mentat-Core automates this process through a modular provisioning framework focused on reproducibility, maintainability and portability.

## Why "Mentat"?
In Frank Herbert's *Dune*, Mentats are humans trained to think with exceptional precision, logic and discipline.
Mentat-Core follows the same philosophy: every component has a single responsibility, every decision is deliberate, and every environment should be reproducible.

## Core Principles
✓ Reproducible
✓ Modular
✓ Maintainable
✓ Automated
✓ Documented

## Architecture
bootstrap.sh

        │

        ▼

Checks
        │

        ├── Operating System

        ├── sudo

        ├── Internet

        ├── Git

        └── curl

        │

        ▼

Installers

        │

        ▼

Configuration

        │

        ▼

Verification


## Current Features
| Feature               | Status |
| --------------------- | :----: |
| OS verification       |    ✅   |
| sudo verification     |    ✅   |
| Internet verification |    ✅   |
| Git verification      |    ⏳   |
| curl verification     |    ⏳   |
| Install Ansible       |    ⏳   |

## Roadmap

## Project Structure
├── bootstrap.sh

├── CHANGELOG

├── docs

│   └── architecture.md

├── lib

│   ├── checks

│   │   ├── internet.sh

│   │   ├── os.sh

│   │   └── sudo.sh

│   ├── configuration

│   ├── core

│   ├── init.sh

│   ├── installers

│   ├── logging.sh

│   └── verification

└── README.md

## Installation
git clone ...

cd mentat-core

./bootstrap.sh

## Usage

## Development Workflow
Issue

↓

Branch

↓

Development

↓

Testing

↓

Review

↓

Merge

## Future Vision
Mentat-Core is intended to evolve into a complete provisioning framework capable of deploying fully reproducible bioinformatics workstations for research laboratories, HPC environments and cloud infrastructures.

## License