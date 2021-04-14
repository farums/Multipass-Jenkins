#!/usr/bin/env bash
################################################################################
# 👉                          provision                                  👈   #
################################################################################
function provision(){
    create_directory_if_not_exists "$SSH_KEY_PATH"
    generate_ssh_key
    create_cloud_init_config_from_template "$VM_NAME"
    Generate_multipass
    create_ssh_connect_script
    create_ansible_inventory_from_template

    echo "Next: SSH to $VM_NAME via Multipass or Bastion Host"
    echo -e "${GREEN} Dome  Greate VM${NC}"
}
################################################################################
# 👉                          Generate WM                                👈   #
################################################################################
function Generate_multipass(){
    local CLOUD_INIT_FILE="$CONFIG_BASE_PATH/${VM_NAME}-cloud-init.yaml"
    # Generate WM
    multipass launch --name ${VM_NAME} --mem ${MEMORY} --cpus ${CPU} --cloud-init "$CLOUD_INIT_FILE" || exit
    IP=$(multipass info "$VM_NAME" | grep IPv4 | awk '{print $2}')
    multipass exec  ${VM_NAME} -- cloud-init status --wait
    #multipass.exe exec  docker  -- cloud-init  status  --long
    echo -e "${BLUE} Generate WM done IP: ${IP} ${NC}"
    #multipass exec "${VM_NAME}" -- sudo cat ~/.ssh/authorized_keys

    #multipass exec "${VM_NAME}" -- sudo iptables -P FORWARD ACCEPT
    echo -e "${YELLOW} multipass.exe exec ${VM_NAME} -- sudo cat ~/.ssh/authorized_keys${NC}"
}
################################################################################
# 👉                            destroy                                  👈   #
#                             Удаления WM                                      #
################################################################################
function destroy(){
    multipass stop ${VM_NAME}
    multipass delete ${VM_NAME}
    multipass purge
    clear_workspace
    echo -e "${BLUE}destroy ${GREEN} $VM_NAME Destroyed${NC}"
}

function clear_workspace(){
    rm -fr "$CONFIG_BASE_PATH/${VM_NAME}-cloud-init.yaml"
    rm -fr "$CONFIG_BASE_PATH/${VM_NAME}-ssh-config"
    rm -fr "$CONFIG_BASE_PATH/${VM_NAME}-ssh-connect.sh"
    rm -fr "$CONFIG_BASE_PATH/hosts"
    rm -fr "$SSH_KEY_PATH"
    echo -e "${BLUE}clear ${GREEN} Workspace files cleared${NC}"
}

function list_vms(){
    multipass ls
}

function run_main(){
    provision
    list_vms
    clear_workspace
    destroy
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
  if ! run_main
  then
    exit 1
  fi
fi