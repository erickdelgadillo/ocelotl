#!/usr/bin/env bash

# ----------------------------------------------------------------------
# verify_os
#
# Verify that the operating system is supported by Ocelotl.
# ----------------------------------------------------------------------

readonly SUPPORTED_OS="ubuntu"
readonly SUPPORTED_VERSIONS=("22.04" "24.04")

is_supported_version() {
    local detected_version="$1"
    local supported_version

    for supported_version in "${SUPPORTED_VERSIONS[@]}"; do
        if [[ "$detected_version" == "$supported_version" ]]; then
            return 0
        fi
    done

    return 1
}

verify_os() {
    if [[ ! -r /etc/os-release ]]; then
        log_error "Unable to read /etc/os-release."
        return 1
    fi

    # Load operating-system metadata.
    source /etc/os-release

    log_info "Detected operating system: ${PRETTY_NAME:-unknown}"

    if [[ "${ID:-}" != "$SUPPORTED_OS" ]]; then
        log_error "Ocelotl currently supports Ubuntu only."
        return 1
    fi

    if ! is_supported_version "${VERSION_ID:-}"; then
        log_error "Unsupported Ubuntu version: ${VERSION_ID:-unknown}."
        log_error "Supported versions: ${SUPPORTED_VERSIONS[*]}."
        return 1
    fi

    log_success "Supported Ubuntu version detected."
}