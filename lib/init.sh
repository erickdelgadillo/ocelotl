#!/usr/bin/env bash

# Directory containing Mentat-Core's internal Bash library.
readonly LIB_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

source "${LIB_DIR}/logging.sh"
source "${LIB_DIR}/checks/os.sh"
source "${LIB_DIR}/checks/sudo.sh"
source "${LIB_DIR}/checks/internet.sh"
source "${LIB_DIR}/checks/git.sh"