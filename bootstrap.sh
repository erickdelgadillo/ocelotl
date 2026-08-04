#!/usr/bin/env bash

# ----------------------------------------------------------------------
# Mentat-Core Bootstrap
#
# Entry point of the Mentat-Core provisioning framework.
#
# Responsibilities:
#   - Load the internal libraries.
#   - Execute system checks.
#   - Start the provisioning workflow.
# ----------------------------------------------------------------------

set -Eeuo pipefail

readonly SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/lib/init.sh"

# ----------------------------------------------------------------------
# Main workflow
# ----------------------------------------------------------------------

main() {
    verify_os
    verify_sudo
    verify_internet
    verify_git
    verify_curl
}

main "$@"