#!/usr/bin/env bash

# ----------------------------------------------------------------------
# install_ansible
#
# Install Ansible Core using Ubuntu's package repositories.
# ----------------------------------------------------------------------

install_ansible() {
    log_info "Updating APT package index..."

    if ! sudo apt-get update; then
        log_error "Failed to update the APT package index."
        return 1
    fi

    log_info "Installing Ansible Core..."

    if ! sudo apt-get install --yes ansible-core; then
        log_error "Failed to install Ansible Core."
        return 1
    fi

    log_success "Ansible Core installation completed."
}