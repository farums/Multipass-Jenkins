#!/usr/bin/env bash

help(){
    echo -e "${BLUE}Ansible-Bash или Ansible-Ping ${GREEN}_vm_name_${NC}"
    echo -e "${YELLOW}ssh -i _private_key_ _USER_@_ip_${NC}"
    echo "                or                "
    echo -e "${YELLOW}ansible -i /config/hosts -m ping all${NC}"
    echo -e "${YELLOW}cat $HOME/.ssh/known_hosts${NC}"
}

export BLUE='\033[1;34m'
export GREEN='\033[0;32m'
export RED='\033[0;31m'
export YELLOW='\033[0;33m'
export NC='\033[0m'
IP='_ip_'

echo -e "${BLUE}Ansible Start${NC}"
echo -e "${BLUE}Запусk:${YELLOW} docker-ssh-connect.sh${NC}"
echo -e "${BLUE}HOME ansible:${NC} $HOME"
#echo -e "`ansible --version`"
echo -e "${BLUE}IP:${NC} ${IP}"
[ -d "$HOME/.ssh/" ] || mkdir -p "$HOME/.ssh/"
eval "$(ssh-agent -s)"
ssh-add -k _private_key_
echo "ssh-keyscan -t rsa ${IP}"
ssh-keyscan -t rsa ${IP} >> "$HOME/.ssh/known_hosts"

echo -e "${GREEN}Done:${YELLOW} docker-ssh-connect.sh${NC}"