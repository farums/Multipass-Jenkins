#!/usr/bin/env bash
################################################################################
# 👉                      generate_ssh_key                                 👈 #
################################################################################
function generate_ssh_key() {
    echo -e 'y\n' | ssh-keygen -b 2048 -t rsa \
                        -f "$SSH_KEY_PATH/${SSH_KEY_NAME}" \
                        -C "${USER}@$DOMAIN" -q -N "" 2>&1 > /dev/null 2>&1
    # Fix Permission For Private Key
    chmod 400 "$SSH_KEY_PATH"/"${SSH_KEY_NAME}"
    echo -e "${BLUE} generate_ssh_key: ${GREEN} ${SSH_KEY_NAME} & ${SSH_KEY_NAME}.pub keys generated successfully ${NC}"
}

function create_ssh_connect_script(){
    local SSH_CONNECT_FILE="$CONFIG_BASE_PATH/${VM_NAME}-ssh-connect.sh"
    cp "$SSH_CONNECT_TEMPLATE" "$SSH_CONNECT_FILE"
    chmod a+x "$SSH_CONNECT_FILE"

    IP=$(multipass info "$VM_NAME" | grep IPv4 | tr --delete "\r"| awk '{print $2}')

    file_replace_text "_private_key_" "/keys/${SSH_KEY_NAME}"    "$SSH_CONNECT_FILE"
    file_replace_text "_vm_name_"     "${VM_NAME}.local"         "$SSH_CONNECT_FILE"
    file_replace_text "_ssh_config_"  "${VM_NAME}-ssh-config"    "$SSH_CONNECT_FILE"
    file_replace_text "_ip_"          "${IP}"                    "$SSH_CONNECT_FILE"
    file_replace_text "_USER_"        "${USER}"                  "$SSH_CONNECT_FILE"


    local SSH_CONFIG="$CONFIG_BASE_PATH/${VM_NAME}-ssh-config"
    ## create ssh-config
    echo -e "Host $VM_NAME.local\n\tHostname ${IP}\n\tUser ${USER}\n\tIdentityFile /keys/${SSH_KEY_NAME}\n" > "$SSH_CONFIG"

    local MSG="$SSH_CONNECT_FILE & $SSH_CONFIG Generated for $VM_NAME that is Provisioned with $IP"
    echo -e "${BLUE} create_ssh_connect_script ${GREEN} ${MSG} ${NC}"
}
################################################################################
# 👉                     2 ssh_via_bastion                                 👈 #
#                          docker ansible                                      #
#                 https://github.com/cytopia/docker-ansible                    #
################################################################################
function ssh_via_bastion(){
  create_ssh_connect_script
  CMD="source /config/${VM_NAME}-ssh-connect.sh && help && bash"
  docker run --rm -it --user ansible \
            -v "${PWD}/$SSH_KEY_PATH":/keys \
            -v "${PWD}/$CONFIG_BASE_PATH":/config \
            cytopia/ansible:latest-tools bash -c "$CMD"
}

function run_main(){
    generate_ssh_key
    create_ssh_connect_script
    ssh_via_bastion
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
  if ! run_main
  then
    exit 1
  fi
fi