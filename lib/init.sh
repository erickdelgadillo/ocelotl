#!/usr/bin/env bash

# ----------------------------------------------------------------------
# Initialization
#
# Load the internal Mentat-Core libraries required by bootstrap.sh.
# ----------------------------------------------------------------------

# Directory containing Mentat-Core's internal Bash library.
readonly LIB_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

source "${LIB_DIR}/logging.sh"
source "${LIB_DIR}/checks/os.sh"
source "${LIB_DIR}/checks/sudo.sh"
source "${LIB_DIR}/checks/internet.sh"
source "${LIB_DIR}/checks/git.sh"
source "${LIB_DIR}/checks/curl.sh"