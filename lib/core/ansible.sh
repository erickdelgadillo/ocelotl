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

    install_ansible

    verify_ansible
}