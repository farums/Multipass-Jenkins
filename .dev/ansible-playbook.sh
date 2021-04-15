#!/usr/bin/env bash
################################################################################
# 👉                         ansible-playbook                              👈 #
################################################################################
# ansible-galaxy collection install community.docker

export ANSIBLE_SCP_IF_SSH=TRUE
export ANSIBLE_CONFIG=/workspace/ansible/ansible.cfg
ansible-playbook /workspace/ansible/simple_playbook.yml

#export ANSIBLE_CONFIG=/workspace/ansible/ansible.cfg && ansible-galaxy install gbraad.docker-registry

