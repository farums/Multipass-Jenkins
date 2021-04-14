#!/usr/bin/env bash
################################################################################
# 👉                        generate hosts                                 👈 #
################################################################################
function create_ansible_inventory_from_template(){
    local SSH_KEY="id_rsa_${VM_NAME}"

    local ANSIBLE_INVENTORY_FILE="$CONFIG_BASE_PATH/hosts"
    cp "$ANSIBLE_INVENTORY_TEMPLATE" "$ANSIBLE_INVENTORY_FILE"

    IP=$(multipass info "$VM_NAME" | grep IPv4 | awk '{print $2}')
    #@ToDo: Optimize Edits
    file_replace_text "_ansible_user_"  "${USER}"                 "$ANSIBLE_INVENTORY_FILE"
    file_replace_text "_sshkey_"        "/keys/${SSH_KEY}"        "$ANSIBLE_INVENTORY_FILE"
    file_replace_text "_vm_name_"       "${VM_NAME}"              "$ANSIBLE_INVENTORY_FILE"
    file_replace_text "_ip_"            "${IP}"                   "$ANSIBLE_INVENTORY_FILE"


    echo -e "${BLUE} Ansibel Inventory ${GREEN}-> ${ANSIBLE_INVENTORY_FILE} generated for ${VM_NAME} that is Provisioned with ${IP} ${NC}"
}
################################################################################
# 👉                        ansible_ping                                   👈 #
################################################################################
function ansible_ping(){
  create_ansible_inventory_from_template
  CMD="source /config/${VM_NAME}-ssh-connect.sh && ansible -i /config/hosts -m ping all"
  docker run --rm -it --user ansible --name ansible_ping \
            -v "${PWD}/$SSH_KEY_PATH":/keys \
            -v "${PWD}/$ANSIBLE_BASE_PATH":/ansible \
            -v "${PWD}/$CONFIG_BASE_PATH":/config \
            cytopia/ansible:latest-tools bash -c "$CMD"

  case "$?" in
    0)
        echo -e "${GREEN}Connection SUCCESS ${NC}:: Ansible Control Center -> VM ";;
    1)
        echo -e "${RED}Error... ${NC} Ansible Control Center Can Not Reach VM via SSH" ;;
  esac
}
################################################################################
# 👉                        configure_vm                                   👈 #
################################################################################
function configure_vm(){
  create_ansible_inventory_from_template

  SOURCE="source /config/${VM_NAME}-ssh-connect.sh"

  OPTS="ANSIBLE_SCP_IF_SSH=TRUE ANSIBLE_CONFIG=/ansible/ansible.cfg ANSIBLE_GATHERING=smart"
  PLAYBOOK="/ansible/simple_playbook.yml"
  CONFIGURE="$OPTS ansible-playbook -i /config/hosts -v $PLAYBOOK"
  INSTALL="$OPTS ansible-galaxy install -r /ansible/requirements.yml --force"

  CMD="$SOURCE && $INSTALL && $CONFIGURE"

  docker run --rm -it --user ansible --name ansible_configure_vm \
            -v "${PWD}/$SSH_KEY_PATH":/keys \
            -v "${PWD}/$ANSIBLE_BASE_PATH":/ansible \
            -v "${PWD}/$CONFIG_BASE_PATH":/config \
            cytopia/ansible:latest-tools bash -c "$CMD"

  case "$?" in
    0)
        echo "VM Configration SUCCESSFULL " ;;
    1)
        echo "VM Configration FAILED " ;;
  esac
}

function run_main(){
  create_ansible_inventory_from_template
  ansible_ping
  configure_vm
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
  if ! run_main
  then
    exit 1
  fi
fi