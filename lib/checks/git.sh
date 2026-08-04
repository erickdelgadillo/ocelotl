#!/usr/bin/env bash

verify_git() {
    log_info "Checking Git availability..."

    if ! command -v git >/dev/null 2>&1; then
        log_error "Git is not installed."
        return 1
    fi

    local git_version
    git_version="$(git --version)"

    log_success "${git_version} detected."
}