# VSCode Remote Development - Разработка внутри контейнеров
`pip3 --version`
 [ansible](https://github.com/hiberbee/ansible-collection-devops/blob/ecb22d0decdbd8f9968e3c5db293e8258ec4bc5d/entrypoint.sh)


Эта папка содержит файлы конфигурации, которые можно использовать для работы с этим репозиторием в [Docker container](https://www.docker.com/resources/what-container) с помощью [VSCode](https://code.visualstudio.com/) удаленной разработки (см. Ниже)..

## 🚀 [Удаленная разработка Visual Studio Code](vscode:extension/ms-vscode-remote.vscode-remote-extensionpack)

1. [Удаленный - Containers](vscode:extension/ms-vscode-remote.remote-containers) — Работайте с изолированной цепочкой инструментов или приложением на основе контейнера, открывая любую папку внутри (или вмонтированную) в контейнер.
2. [Удаленный - SSH](vscode:extension/ms-vscode-remote.remote-ssh) — Разработка кода, расположенного на удаленной / виртуальной машине
3. [Удаленный - WSL](vscode:extension/ms-vscode-remote.remote-wsl) — Разработка кода в среде Linux не выходя из машины Windows.

## 📄 Применение

Предварительное условие: [установите Docker](https://docs.docker.com/install) в вашей локальной среде.
Для начала прочтите и следуйте инструкциям в разделе [Разработка внутри контейнера](https://code.visualstudio.com/docs/remote/containers). [.devcontainer/](.) каталог содержит предварительно сконфигурированные `devcontainer.json` и `Dockerfil` файлы, которые вы можете использовать , чтобы настроить удаленную разработку с **Docker контейнера**.

Вкратце, вам необходимо::

- Установите расширение [Remote - Containers](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) extension.
- Откройте VSCode и откройте [Command Palette](https://code.visualstudio.com/docs/getstarted/userinterface#_command-palette).
- Введите `Remote-Containers: Open Folder in Container` выберите локальный клон.
- [[F1]] Run **Remote-Containers: Reopen Folder in Container**.

## ♻️ Updating `devcontainer.json` and `Dockerfile`

Вы можете обновить и зафиксировать рекомендуемые файлы конфигурации (которые люди используют в качестве основы для своих локальных конфигураций), если вы обнаружите, что что-то сломано, устарело или может быть улучшено.

