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

# ----------------------------------------------------------------------
# run_workstation_playbook
#
# Execute the main Ocelotl provisioning playbook.
# ----------------------------------------------------------------------

run_workstation_playbook() {
    log_info "Starting workstation provisioning..."

    ANSIBLE_CONFIG="${SCRIPT_DIR}/ansible.cfg" \
        ansible-playbook \
        -i "${SCRIPT_DIR}/inventory/localhost.ini" \
        "${SCRIPT_DIR}/playbooks/workstation.yml" \
        --ask-become-pass
}