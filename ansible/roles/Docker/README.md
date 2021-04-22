# Docker

## add User

Если вы хотите использовать Docker как пользователь без полномочий root, вам следует подумать о добавлении своего пользователя в группу «docker», например: `sudo usermod -aG docker <your-user>` или для jenkins: `sudo usermod -aG docker jenkins`
