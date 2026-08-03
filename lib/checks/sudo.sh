#!/usr/bin/env bash

verify_sudo() {
    if ! command -v sudo >/dev/null 2>&1; then
        log_error "sudo is not installed."
        return 1
    fi

    log_info "Verifying sudo privileges..."

    if ! sudo -v; then
        log_error "Sudo privileges are required to continue."
        return 1
    fi

    log_success "Sudo privileges verified."
}