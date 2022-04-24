args = `arg="$(filter-out $@,$(MAKECMDGOALS))" && echo $${arg:-${1}}`
SELF := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

init:
	@bash ./ssh-connect.sh
tree:
	tree
start:
	@bash ./ansible-playbook.sh
ping:
	@bash -c "export ANSIBLE_CONFIG=/workspace/ansible/ansible.cfg && ansible all -m ping  -vvv"
ssh:
	@bash -c "ssh -i /keys/id_rsa_jenkins root@172.17.122.252"