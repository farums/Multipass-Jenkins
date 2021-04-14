#!/usr/bin/env bash
################################################################################
# 👉                         ansible-playbook                              👈 #
################################################################################

export ANSIBLE_SCP_IF_SSH=TRUE
export ANSIBLE_CONFIG=/workspace/ansible/ansible.cfg
ansible-playbook /workspace/ansible/simple_playbook.yml

#ll /keys
#IP='172.20.253.45'
#ssh-keyscan -t rsa ${IP} >> "$HOME/.ssh/known_hosts"
#cat /root/.ssh/known_hosts

#export ANSIBLE_CONFIG=/workspace/ansible/ansible.cfg && ansible-galaxy install gantsign.oh-my-zsh
#export ANSIBLE_CONFIG=/workspace/ansible/ansible.cfg && ansible-galaxy install nickjj.docker
#export ANSIBLE_CONFIG=/workspace/ansible/ansible.cfg && ansible-galaxy install asg1612.ansible-role-docker-registry
#export ANSIBLE_CONFIG=/workspace/ansible/ansible.cfg && ansible-galaxy install wunzeco.docker-registry-v2
#export ANSIBLE_CONFIG=/workspace/ansible/ansible.cfg && ansible-galaxy install freehck.docker_registry
#export ANSIBLE_CONFIG=/workspace/ansible/ansible.cfg && ansible-galaxy install gbraad.docker-registry

