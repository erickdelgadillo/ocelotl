#!/usr/bin/env bash

# ----------------------------------------------------------------------
# Ocelotl Bootstrap
#
# Entry point of the Ocelotl provisioning framework.
#
# Responsibilities:
#   - Load the internal libraries.
#   - Execute system checks.
#   - Ensure Ansible is available.
#   - Start the provisioning workflow.
# ----------------------------------------------------------------------

set -Eeuo pipefail

readonly SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/lib/init.sh"

# ----------------------------------------------------------------------
# Main workflow
# ----------------------------------------------------------------------

main() {
    local profile="${1:-full}"
    if [[ "$profile" == "--help" || "$profile" == "-h" ]]; then
        printf "Usage: ./bootstrap.sh [full|base|development|bioinformatics|desktop|ai]\n"
        printf "Default: full. Security profile is not implemented yet.\n"
        return 0
    fi
    case "$profile" in
        full|base|development|bioinformatics|desktop|ai) ;;
        *) printf "Unknown profile: %s\n" "$profile" >&2; return 2 ;;
    esac
    verify_os
    verify_sudo
    verify_internet
    verify_git
    verify_curl

    ensure_ansible

    run_workstation_playbook "$profile"
}

main "$@"