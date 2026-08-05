#!/usr/bin/env bash

# ----------------------------------------------------------------------
# ensure_ansible
#
# Ensure that Ansible Core is available before provisioning begins.
# ----------------------------------------------------------------------

ensure_ansible() {
    if verify_ansible; then
        return 0
    fi

    log_info "Ansible Core must be installed."

    if ! install_ansible; then
        log_error "Ansible Core could not be installed."
        return 1
    fi

    if ! verify_ansible; then
        log_error "Ansible Core installation could not be verified."
        return 1
    fi

    return 0
}