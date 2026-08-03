#!/usr/bin/env bash

set -Eeuo pipefail

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

main() {
    if [[ ! -r /etc/os-release ]]; then
        echo "Error: unable to read /etc/os-release." >&2
        exit 1
    fi

    source /etc/os-release

    echo "Detected operating system: ${PRETTY_NAME:-unknown}"

    if [[ "${ID:-}" != "$SUPPORTED_OS" ]]; then
        echo "Error: Mentat-Core currently supports Ubuntu only." >&2
        exit 1
    fi

    if ! is_supported_version "${VERSION_ID:-}"; then
        echo "Error: unsupported Ubuntu version: ${VERSION_ID:-unknown}." >&2
        echo "Supported versions: ${SUPPORTED_VERSIONS[*]}." >&2
        exit 1
    fi

    echo "Supported Ubuntu version detected."
}

main "$@"