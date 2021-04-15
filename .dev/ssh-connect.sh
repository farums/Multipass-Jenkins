#!/usr/bin/env bash
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
################################################################################
# 👉                             ADD KEY SSH                               👈 #
################################################################################
if [ -d "/keys/" ]; then
    echo " ===>   ADD KEY SSH   <==="
    mkdir -p "/keys/"
    cp /workspace/keys/* /keys
    chmod 600  /keys/id_rsa_jenkins

    [ -d "$HOME/.ssh/" ] || mkdir -p "$HOME/.ssh/"
    eval "$(ssh-agent -s)"
    ssh-add -k /keys/id_rsa_jenkins
    echo " ===>   DONE SSH     <==="
fi
################################################################################
# 👉                             Start  ansible all                        👈 #
################################################################################
ansible -i /workspace/ansible/hosts -m ping all
# load playbook
source "$SCRIPT_DIR/ansible-playbook.sh"