#!/bin/ash

USERNAME=${2:-"vscode"}
USER_UID=${3:-"1000"}
USER_GID=${4:-"1000"}

set -e

if [ "$(id -u)" -ne 0 ]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

# Убедитесь, что оболочки входа в систему получают правильный путь, если пользователь обновил PATH с помощью ENV.
rm -f /etc/profile.d/00-restore-env.sh
echo "export PATH=${PATH//$(sh -lc 'echo $PATH')/\$PATH}" > /etc/profile.d/00-restore-env.sh
chmod +x /etc/profile.d/00-restore-env.sh

# code shim, it fallbacks to code-insiders if code is not available
if [ -f /tmp/build/bin/executable_code ]; then
    cp -f /tmp/build/bin/code  /usr/local/bin/code
    chmod +x /usr/local/bin/code
fi
echo "✔️  common-alpine Done!"
