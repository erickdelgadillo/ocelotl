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
    ansible-playbook --version |
        sed -n '1s/.*\[core \([^]]*\)\].*/\1/p'
}

verify_ansible() {
    log_info "Checking Ansible Core availability..."

    if ! is_ansible_installed; then
        log_warning "Ansible Core is not installed."
        return 1
    fi

    local ansible_version
    ansible_version="$(get_ansible_version)"

    if [[ -z "$ansible_version" ]]; then
        log_error "Unable to determine the Ansible Core version."
        return 1
    fi

    log_success "Ansible Core ${ansible_version} detected."
}