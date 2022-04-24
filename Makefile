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
ls:
	multipass.exe ls
################################################################################
# 👉                          🔑 git                                       👈 #
################################################################################
Tag=1.0
ProjectName=Multipass-Jenkins
ECHO_GIT=$(ProjectName):$(Tag): GIT
GitCommit=$(call args, $(ProjectName):$(Tag))
git: ## GIT  
	@status=$$(git status --porcelain); \
	if [ ! -z "$${status}" ]; \
	then \
		echo "🌍 Eсть изменение фиксируем 📒$(ECHO_GIT)"; \
		echo "📒$(ECHO_GIT) 📄 Add "   && git add .; \
		echo "📒$(ECHO_GIT) 📄 Commit" && git commit -m "♻️ make: $(GitCommit)"; \
		echo "📒$(ECHO_GIT) 📄 Push"   && git push -u origin master; \
		echo "✅ Exit $(ECHO_GIT)"; \
	fi
gitmodules: ## GIT gitmodules
	@$(MAKE) git GitCommit=$(GitCommit)
git-tag:
	@echo "📒 GIT tag"             && git tag -a $(Tag) -m "my version  $(Tag)"
	@echo "📒 GIT push tag $(Tag)" && git push origin $(Tag)
	@echo "📒 GIT tag list " && git tag -l
################################################################################
# 👉                                                                       👈 #
################################################################################