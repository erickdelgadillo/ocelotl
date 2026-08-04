#!/usr/bin/env bash

readonly CONNECTIVITY_URLS=(
    "https://github.com"
    "https://archive.ubuntu.com"
    "https://repo.anaconda.com"
)

check_url_with_curl() {
    local url="$1"

    curl \
        --silent \
        --fail \
        --location \
        --max-time 5 \
        --output /dev/null \
        "$url"
}

check_url_with_wget() {
    local url="$1"

    wget \
        --quiet \
        --spider \
        --timeout=5 \
        "$url"
}

verify_internet() {
    local url

    log_info "Checking Internet connectivity..."

    if ! command -v curl >/dev/null 2>&1 &&
       ! command -v wget >/dev/null 2>&1; then
        log_error "Neither curl nor wget is available to test connectivity."
        return 1
    fi

    for url in "${CONNECTIVITY_URLS[@]}"; do
        if command -v curl >/dev/null 2>&1 &&
           check_url_with_curl "$url"; then
            log_success "Internet connection verified via ${url}."
            return 0
        fi

        if command -v wget >/dev/null 2>&1 &&
           check_url_with_wget "$url"; then
            log_success "Internet connection verified via ${url}."
            return 0
        fi
    done

    log_error "Unable to reach any configured connectivity endpoint."
    return 1
}