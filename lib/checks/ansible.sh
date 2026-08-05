#!/usr/bin/env bash

# ----------------------------------------------------------------------
# Ansible checks
#
# Verify that Ansible Core is installed and report its version.
# ----------------------------------------------------------------------

is_ansible_installed() {
    command -v ansible-playbook >/dev/null 2>&1
}

get_ansible_version() {
    ansible-playbook --version | awk 'NR == 1 {print $3}'
}

verify_ansible() {
    log_info "Checking Ansible Core availability..."

    if ! is_ansible_installed; then
        log_warning "Ansible Core is not installed."
        return 1
    fi

    local ansible_version
    ansible_version="$(get_ansible_version)"

    log_success "Ansible Core ${ansible_version} detected."
}