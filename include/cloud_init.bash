#!/usr/bin/env bash

function create_cloud_init_config_from_template() {
    local SSH_KEY="id_rsa_${VM_NAME}"
    local CLOUD_INIT_FILE="$CONFIG_BASE_PATH/${VM_NAME}-cloud-init.yaml"
    cp "$CLOUD_INIT_TEMPLATE" "$CLOUD_INIT_FILE"

    file_replace_text "{{hostname}}"   "$VM_NAME.local"                          "$CLOUD_INIT_FILE"
    file_replace_text "{{name}}"         "${USER}"                                 "$CLOUD_INIT_FILE"
    file_replace_text "{{gecos}}"        "${USER}"                                 "$CLOUD_INIT_FILE"
    file_replace_text "{{admin_ssh_rsa}}"        "$(cat "$SSH_KEY_PATH"/"${SSH_KEY}".pub)" "$CLOUD_INIT_FILE"
    file_replace_text "_rsyslog_ip_port_" "$(get_local_ip):5514"                    "$CLOUD_INIT_FILE"

    echo -e "${BLUE} create_cloud_init_config_from_template ${GREEN} $CLOUD_INIT_FILE Generated for $VM_NAME${NC}"
}

function run_main(){
    create_cloud_init_config_from_template
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
  if ! run_main "$@"
  then
    exit 1
  fi
fi