#!/usr/bin/env bash

# ----------------------------------------------------------------------
# Logging functions
#
# Provide standardized colored output for Mentat-Core.
# ----------------------------------------------------------------------

readonly COLOR_RESET="\033[0m"

readonly COLOR_BLUE="\033[34m"
readonly COLOR_GREEN="\033[32m"
readonly COLOR_YELLOW="\033[33m"
readonly COLOR_RED="\033[31m"

log_info() {
    printf "${COLOR_BLUE}[INFO]${COLOR_RESET} %s\n" "$1"
}

log_success() {
    printf "${COLOR_GREEN}[SUCCESS]${COLOR_RESET} %s\n" "$1"
}

log_warning() {
    printf "${COLOR_YELLOW}[WARNING]${COLOR_RESET} %s\n" "$1"
}

log_error() {
    printf "${COLOR_RED}[ERROR]${COLOR_RESET} %s\n" "$1" >&2
}