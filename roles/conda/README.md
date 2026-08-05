# Conda role

## Responsibility

Provide a functional and consistently configured Conda installation suitable for bioinformatics.

## Guarantees

When this role finishes successfully:

- An existing Conda installation is preserved.
- Miniforge is installed when Conda is not available.
- The `libmamba` solver is configured.
- Channel priority is set to `strict`.
- `conda-forge` and `bioconda` are available.
- Conda is initialized for the user's shell.
- The Conda installation is verified.

## Non-goals

- Remove or replace an existing Conda installation.
- Delete existing environments.
- Modify environments created by the user.
- Force upgrades of Conda or installed packages.