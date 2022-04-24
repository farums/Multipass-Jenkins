#!/usr/bin/env bash

# shellcheck disable=SC1090
source "$(dirname "${BASH_SOURCE[0]}")/actions.bash"

function provision_vm(){
    check_and_exit_if_vm_exists
    start=$(date +%s)
    provision
    end=$(date +%s)
    runtime=$((end-start))
    display_time $runtime
}

function provision_bastion(){
  docker pull cytopia/ansible:latest-tools
}

function ssh_to_bastion_vm(){
    check_and_exit_if_vm_not_running
    export CONFIG_BASE_PATH
    export VM_NAME
    export SSH_KEY_PATH
    ssh_via_bastion
}

function ansible_ping_from_bastion_to_vm(){
    check_and_exit_if_vm_not_running
    export CONFIG_BASE_PATH
    export VM_NAME
    export SSH_KEY_PATH
    ansible_ping
}

function configure_vm_from_bastion(){
    check_and_exit_if_vm_not_running
    ## Explicitly exporting to make it available in docket-compose
    export CONFIG_BASE_PATH
    export VM_NAME
    export SSH_KEY_PATH
    configure_vm
}

function destroy_vm(){
    check_and_exit_if_vm_not_running
    destroy
}

function list_all_vms(){
  list_vms
}

function clear_local_workspace(){
  clear_workspace
}

function vm_api_execute_action(){
    opt="$1"
    choice=$( tr '[:upper:]' '[:lower:]' <<<"$opt" )
    case $choice in
        10  | provision_vm)                    provision_vm ;;
        20  | provision_bastion)               provision_bastion ;;
        30  | ansible_ping_from_bastion_to_vm) ansible_ping_from_bastion_to_vm ;;
        40  | ssh_to_bastion_vm)               ssh_to_bastion_vm ;;
        50  | configure_vm_from_bastion)       configure_vm_from_bastion ;;
        80  | list_all_vms)                    list_all_vms ;;
        90  | destroy_vm)                      destroy_vm ;;
    esac
}

function run_main(){
    provision_vm
    provision_bastion
    ssh_to_bastion_vm
    ansible_ping_from_bastion_to_vm
    configure_vm_from_bastion
    list_all_vms
    destroy_vm
    vm_api_execute_action "$@"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
  if ! run_main "$@"
  then
    exit 1
  fi
fi
