#!/usr/bin/env bash

# ----------------------------------------------------------------------
# verify_curl
#
# Verify that curl is installed and report its version.
# ----------------------------------------------------------------------

verify_curl() {
    log_info "Checking curl availability..."

    if ! command -v curl >/dev/null 2>&1; then
        log_error "curl is not installed."
        return 1
    fi

    local curl_version
    curl_version="$(curl --version | head -n 1)"

    log_success "${curl_version} detected."
}