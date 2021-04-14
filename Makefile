args = `arg="$(filter-out $@,$(MAKECMDGOALS))" && echo $${arg:-${1}}`
SELF := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
include $(SELF)/instance.env

init:
	@bash $(SELF)/multipass.bash
list:
    # vm_api_execute_action => list_all_vms
	@bash $(SELF)/Api.bash "list_all_vms"
docker-compose:
	@multipass.exe exec $(VM_NAME) -- docker --version
	@multipass.exe exec $(VM_NAME) -- docker-compose -version
hosts:
	@cat /mnt/c/Windows/System32/drivers/etc/hosts
delete-all:
	@bash $(SELF)/include/multipass/delete_all.bash

start:
	@echo "Запустить Виртуальную машину если остановлена"
	@echo "Обновить hosts файл IP=$(multipass info "$VM_NAME" | grep IPv4 | tr --delete "\r"| awk '{print $2}')"
	@echo "Запустить devcontainer ansible"
	powershell.exe ./vscode-dev.ps1