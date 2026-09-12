# R role

Installs and validates an R environment for scientific computing, data
analysis, and bioinformatics on Ubuntu.

The role manages system dependencies needed to compile common R packages,
detects or installs R, optionally installs RStudio Desktop, installs curated
packages from CRAN, Bioconductor, and GitHub, and verifies the resulting R
environment.

## Responsibilities

The role executes the following workflow:

1. Installs Ubuntu development and library dependencies required by common
   scientific R packages.
2. Detects an existing R installation with `R --version`.
3. On a clean system, configures the CRAN Ubuntu repository and installs
   `r-base` and `r-base-dev`.
4. Optionally detects or installs RStudio Desktop.
5. Installs missing CRAN packages from the configured CRAN mirror.
6. Installs missing Bioconductor packages with `BiocManager`.
7. Installs missing GitHub packages with `remotes::install_github()`.
8. Verifies R, optional RStudio, and every requested package.

## Default variables

### R and RStudio

| Variable | Default | Description |
| --- | --- | --- |
| `r_install_rstudio` | `true` | Whether to install and verify RStudio Desktop when it is not already available. |
| `r_rstudio_version` | `2026.07.1-147` | RStudio Desktop package version used on clean systems. |
| `r_rstudio_deb_url` | Derived from `r_rstudio_version` | URL of the RStudio Desktop `.deb` package. |
| `r_cran_repo` | `https://cloud.r-project.org` | CRAN repository used for R package installation. |

### System dependencies

`r_system_packages` defines the APT packages installed before R package
installation:

```yaml
r_system_packages:
  - build-essential
  - cmake
  - libcurl4-openssl-dev
  - libssl-dev
  - libxml2-dev
  - libuv1-dev
  - libfontconfig1-dev
  - libfreetype6-dev
  - libharfbuzz-dev
  - libfribidi-dev
  - libmagick++-dev
  - libudunits2-dev
  - libgdal-dev
  - libgeos-dev
  - libproj-dev
  - xz-utils
```

These dependencies support compilation and use of packages involving web
requests, XML, fonts, graphics, image processing, units, and geospatial
libraries.

### R packages

The role exposes three package collections:

| Variable | Source | Installation method |
| --- | --- | --- |
| `r_cran_packages` | CRAN | `install.packages()` |
| `r_bioconductor_packages` | Bioconductor | `BiocManager::install()` |
| `r_github_packages` | GitHub repositories | `remotes::install_github()` |

The default CRAN collection includes R infrastructure, data manipulation,
plotting, import/export, ecology and statistics, reporting, and utility
packages. It includes `BiocManager` and `remotes`, which are required by the
Bioconductor and GitHub installation phases.

The default Bioconductor collection is:

```yaml
r_bioconductor_packages:
  - limma
  - edgeR
  - ComplexHeatmap
  - ALDEx2
```

Bioconductor mirrors are tried in order through `r_bioc_mirrors`:

```yaml
r_bioc_mirrors:
  - https://bioconductor.org
  - https://bioconductor.statistik.tu-dortmund.de
```

The default GitHub packages are:

```yaml
r_github_packages:
  - name: kfigr
    repo: mkoohafkan/kfigr
  - name: ggbiplot
    repo: vqv/ggbiplot
  - name: CoDaSeq
    repo: ggloor/CoDaSeq/CoDaSeq
  - name: ggord
    repo: fawda123/ggord
```

`name` is the package name used for detection and validation. `repo` is passed
to `remotes::install_github()`.

## Package library location

CRAN, Bioconductor, and GitHub packages are installed in the user's R library
defined by `R_LIBS_USER`.

The role creates that directory when necessary and prepends it to `.libPaths()`.
It fails deliberately if `R_LIBS_USER` cannot be determined. This avoids
installing user-managed packages into a system library and permits package
installation without running R itself as root.

Ensure that the user running the playbook has a usable `R_LIBS_USER`
configuration before provisioning.

## Example playbook

```yaml
---
- name: Provision an R analysis environment
  hosts: localhost
  connection: local

  roles:
    - role: r
```

Override package collections or disable RStudio in inventory or variables files:

```yaml
r_install_rstudio: false

r_cran_packages:
  - BiocManager
  - remotes
  - dplyr
  - ggplot2
  - vegan

r_bioconductor_packages:
  - edgeR
  - ALDEx2
```

Use a separate, ignored variables file or Ansible Vault for private
configuration. Do not add credentials, tokens, private repositories, or
institution-specific paths to role defaults.

## Validation

The role verifies:

```bash
R --version
rstudio --version
```

RStudio validation runs only when `r_install_rstudio` is `true`.

It also verifies that every requested CRAN, Bioconductor, and GitHub package,
plus R's built-in `grid` package, can be loaded with `requireNamespace()`.

After provisioning, you can inspect the active library paths and test a
package manually:

```bash
Rscript --vanilla -e '.libPaths(); packageVersion("ggplot2")'
```

## Idempotence

R and RStudio are detected before installation. Package installation tasks
calculate the set of missing packages and install only those packages. They
report a change only when packages were added.

The role does not automatically upgrade installed R packages. Existing
packages are retained unless they are absent from the active library.

## Reproducibility notes

CRAN and Bioconductor package versions are resolved at installation time.
GitHub package references are not pinned to commits or release tags by default.
For a strictly reproducible analysis environment, use a project-level lockfile
such as `renv.lock`, pin GitHub package references, and record the R version
and operating-system release used for provisioning.
