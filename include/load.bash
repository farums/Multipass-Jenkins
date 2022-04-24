#!/usr/bin/env bash
## To get all functions : bash -c "source src/load.bash && declare -F"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# load
source "$SCRIPT_DIR/function.sh"
source "$SCRIPT_DIR/cloud_init.bash"
source "$SCRIPT_DIR/ssh.bash"
source "$SCRIPT_DIR/ansible.bash"
source "$SCRIPT_DIR/cli_builder.bash"

# shellcheck source=src/multipass/actions.bash
source "$SCRIPT_DIR/multipass/actions.bash"
# shellcheck source=src/multipass/checks.bash
source "$SCRIPT_DIR/multipass/checks.bash"
# shellcheck source=src/multipass/vm_api.bash
source "$SCRIPT_DIR/multipass/vm_api.bash"