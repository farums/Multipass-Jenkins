#!/usr/bin/env bash

# Checks if required env variables for instance is all set
function raise(){
  echo "${1}" >&2
}

function raise_error(){
  echo -e "${RED}Eroro ${NC} ${1}" >&2
  exit 1
}

function check_and_exit_if_vm_not_running(){
  multipass info "$VM_NAME" || raise_error "VM -> $VM_NAME нету!"
}

function check_and_exit_if_vm_exists(){
   [ "$( multipass list | grep -c "$VM_NAME")"   -ne 0  ] && raise_error "VM -> $VM_NAME Уже создана!"
}

# Wrapper To Aid TDD
function run_main(){
    check_and_exit_if_vm_not_running
    check_and_exit_if_vm_exists
}

# Wrapper To Aid TDD
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
  if ! run_main "$@"
  then
    exit 1
  fi
fi